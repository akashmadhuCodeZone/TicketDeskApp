using System.Data;
using System.Data.SqlClient;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Tickets;
using TicketDesk.Utility.Logger;

namespace TicketDesk.DAL.Domain
{
    public class TicketDataAccess : ITicketDataAccess
    {
        private readonly string _connectionString;
        private readonly Logger _logger;

        public TicketDataAccess(string connectionString, Logger logger) =>
            (_connectionString, _logger) = (connectionString, logger);

        public async Task<List<TicketsDTO>> GetAllTicketsAsync()
        {
            _logger.LogInformation("Fetching all tickets.");
            var tickets = new List<TicketsDTO>();

            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_GetAllTickets", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                await conn.OpenAsync();
                using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    tickets.Add(new TicketsDTO
                    {
                        TicketId = (Guid)reader["TicketId"],
                        TicketTypeId = reader["TicketTypeId"] as int?,
                        DepartmentId = reader["DepartmentId"] as int?,
                        TicketTitle = reader["TicketTitle"].ToString(),
                        TicketDescription = reader["TicketDescription"].ToString(),
                        StatusId = (int)reader["StatusId"],
                        CreatedOn = (DateTime)reader["CreatedOn"],
                        CreatedBy = (Guid)reader["CreatedBy"],
                        ModifiedOn = reader["ModifiedOn"] as DateTime?,
                        ModifiedBy = reader["ModifiedBy"] as Guid?
                    });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, "Error fetching all tickets");
                throw;
            }

            return tickets;
        }

        public async Task<List<TicketsDTO>> GetTicketsByUserAsync(Guid userId)
        {
            _logger.LogInformation($"Fetching tickets for user ID: {userId}");
            var tickets = new List<TicketsDTO>();

            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_GetTicketByUser", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@UserID", userId);

                await conn.OpenAsync();
                using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    tickets.Add(new TicketsDTO
                    {
                        TicketId = (Guid)reader["TicketId"],
                        TicketTypeId = reader["TicketTypeId"] as int?,
                        DepartmentId = reader["DepartmentId"] as int?,
                        TicketTitle = reader["TicketTitle"].ToString(),
                        TicketDescription = reader["TicketDescription"].ToString(),
                        StatusId = (int)reader["StatusId"],
                        CreatedOn = reader["CreatedOn"] as DateTime?,
                        CreatedBy = reader["CreatedBy"] as Guid?,
                        ModifiedOn = reader["ModifiedOn"] as DateTime?,
                        ModifiedBy = reader["ModifiedBy"] as Guid?
                    });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error fetching tickets for user ID: {userId}");
                throw;
            }

            return tickets;
        }

        public async Task<TicketsDTO> GetTicketByIdAsync(Guid ticketId)
        {
            _logger.LogInformation($"Fetching ticket by ID: {ticketId}");
            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_GetTicketById", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@TicketId", ticketId);

                await conn.OpenAsync();
                using var reader = await cmd.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    return new TicketsDTO
                    {
                        TicketId = (Guid)reader["TicketId"],
                        TicketTypeId = reader["TicketTypeId"] as int?,
                        DepartmentId = reader["DepartmentId"] as int?,
                        TicketTitle = reader["TicketTitle"].ToString(),
                        TicketDescription = reader["TicketDescription"].ToString(),
                        StatusId = (int)reader["StatusId"],
                        CreatedOn = (DateTime)reader["CreatedOn"],
                        CreatedBy = (Guid)reader["CreatedBy"],
                        ModifiedOn = reader["ModifiedOn"] as DateTime?,
                        ModifiedBy = reader["ModifiedBy"] as Guid?
                    };
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error fetching ticket by ID: {ticketId}");
                throw;
            }

            return null;
        }

        public async Task<List<TicketsDTO>> GetTicketsWithAgentAsync()
        {
            _logger.LogInformation("Fetching tickets with agent information.");
            var tickets = new List<TicketsDTO>();

            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_GetTicketsWithAgent", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                await conn.OpenAsync();
                using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    tickets.Add(new TicketsDTO
                    {
                        TicketId = (Guid)reader["TicketId"],
                        TicketTitle = reader["TicketTitle"].ToString(),
                        TicketDescription = reader["TicketDescription"].ToString(),
                        StatusId = (int)reader["StatusId"],
                        AgentId = (Guid)reader["AgentId"],
                        AgentName = reader["AgentName"].ToString()
                    });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, "Error fetching tickets with agent information");
                throw;
            }

            return tickets;
        }

        public async Task<bool> CreateTicketAsync(TicketsDTO ticket)
        {
            _logger.LogInformation("Creating new ticket.");
            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_CreateTicket", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@TicketTitle", ticket.TicketTitle);
                cmd.Parameters.AddWithValue("@TicketDescription", ticket.TicketDescription);
                cmd.Parameters.AddWithValue("@StatusId", ticket.StatusId);
                cmd.Parameters.AddWithValue("@UserId", ticket.CreatedBy);

                await conn.OpenAsync();
                using var reader = await cmd.ExecuteReaderAsync();
                return reader.Read() && reader.GetInt32(0) > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, "Error creating ticket");
                throw;
            }
        }

        public async Task<bool> UpdateTicketAsync(TicketsDTO ticket)
        {
            _logger.LogInformation($"Updating ticket ID: {ticket.TicketId}");
            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_UpdateTicket", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@TicketId", ticket.TicketId);
                cmd.Parameters.AddWithValue("@TicketTitle", ticket.TicketTitle);
                cmd.Parameters.AddWithValue("@TicketDescription", ticket.TicketDescription);
                cmd.Parameters.AddWithValue("@StatusId", ticket.StatusId);
                cmd.Parameters.AddWithValue("@UserId", ticket.CreatedBy);

                await conn.OpenAsync();
                using var reader = await cmd.ExecuteReaderAsync();
                return reader.Read() && reader.GetInt32(0) > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error updating ticket ID: {ticket.TicketId}");
                throw;
            }
        }

        public async Task<bool> DeleteTicketAsync(Guid ticketId)
        {
            _logger.LogInformation($"Deleting ticket ID: {ticketId}");
            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_DeleteTicket", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@TicketId", ticketId);

                await conn.OpenAsync();
                int rowsAffected = await cmd.ExecuteNonQueryAsync();
                return rowsAffected > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error deleting ticket ID: {ticketId}");
                throw;
            }
        }
    }
}
