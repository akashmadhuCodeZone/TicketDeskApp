using System.Data;
using System.Data.SqlClient;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.DAL.Domain
{
    public class TicketDataAccess
    {
        private readonly string _connectionString;

        public TicketDataAccess(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<List<TicketsDTO>> GetAllTicketsAsync()
        {
            try
            {
                var tickets = new List<TicketsDTO>();

                using SqlConnection conn = new(_connectionString);
                using SqlCommand cmd = new("usp_GetAllTickets", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                await conn.OpenAsync();
                using SqlDataReader reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    tickets.Add(new TicketsDTO
                    {
                        TicketId = (Guid)reader["TicketId"],
                        TicketTypeId = reader["TicketTypeId"] != DBNull.Value ? (int?)reader["TicketTypeId"] : null,
                        DepartmentId = reader["DepartmentId"] != DBNull.Value ? (int?)reader["DepartmentId"] : null,
                        TicketTitle = reader["TicketTitle"].ToString(),
                        TicketDescription = reader["TicketDescription"].ToString(),
                        StatusId = (int)reader["StatusId"],
                        CreatedOn = (DateTime)reader["CreatedOn"],
                        CreatedBy = (Guid)reader["CreatedBy"],
                        ModifiedOn = reader["ModifiedOn"] as DateTime?,
                        ModifiedBy = reader["ModifiedBy"] as Guid?
                    });
                }
                return tickets;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public async Task<List<TicketsDTO>> GetTicketsByUserAsync(Guid userId)
        {
            try
            {
                var tickets = new List<TicketsDTO>();

                using SqlConnection conn = new(_connectionString);
                using SqlCommand cmd = new("usp_GetTicketByUser", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@UserID", userId);

                await conn.OpenAsync();
                using SqlDataReader reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                {
                    tickets.Add(new TicketsDTO
                    {
                        TicketId = (Guid)reader["TicketId"],
                        TicketTypeId = reader["TicketTypeId"] != DBNull.Value ? (int?)reader["TicketTypeId"] : null,
                        DepartmentId = reader["DepartmentId"] != DBNull.Value ? (int?)reader["DepartmentId"] : null,
                        TicketTitle = reader["TicketTitle"] != DBNull.Value ? reader["TicketTitle"].ToString() : string.Empty,
                        TicketDescription = reader["TicketDescription"] != DBNull.Value ? reader["TicketDescription"].ToString() : string.Empty,
                        StatusId = (int)reader["StatusId"],
                        CreatedOn = reader["CreatedOn"] != DBNull.Value ? (DateTime?)reader["CreatedOn"] : null,
                        CreatedBy = reader["CreatedBy"] != DBNull.Value ? (Guid?)reader["CreatedBy"] : null,
                        ModifiedOn = reader["ModifiedOn"] != DBNull.Value ? (DateTime?)reader["ModifiedOn"] : null,
                        ModifiedBy = reader["ModifiedBy"] != DBNull.Value ? (Guid?)reader["ModifiedBy"] : null
                    });
                }
                return tickets;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        public async Task<TicketsDTO> GetTicketByIdAsync(Guid ticketId)
        {
            try
            {
                using SqlConnection conn = new(_connectionString);
                using SqlCommand cmd = new("usp_GetTicketById", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@TicketId", ticketId);

                await conn.OpenAsync();
                using SqlDataReader reader = await cmd.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    return new TicketsDTO
                    {
                        TicketId = (Guid)reader["TicketId"],
                        TicketTypeId = reader["TicketTypeId"] != DBNull.Value ? (int?)reader["TicketTypeId"] : null,
                        DepartmentId = reader["DepartmentId"] != DBNull.Value ? (int?)reader["DepartmentId"] : null,
                        TicketTitle = reader["TicketTitle"].ToString(),
                        TicketDescription = reader["TicketDescription"].ToString(),
                        StatusId = (int)reader["StatusId"],
                        CreatedOn = (DateTime)reader["CreatedOn"],
                        CreatedBy = (Guid)reader["CreatedBy"],
                        ModifiedOn = reader["ModifiedOn"] != DBNull.Value ? (DateTime?)reader["ModifiedOn"] : null,
                        ModifiedBy = reader["ModifiedBy"] != DBNull.Value ? (Guid?)reader["ModifiedBy"] : null
                    };

                }
                return null;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public async Task<List<TicketsDTO>> GetTicketsWithAgentAsync()
        {
            List<TicketsDTO> tickets = null;
            try
            {
                tickets = new List<TicketsDTO>();
                using (var connection = new SqlConnection(_connectionString))
                {
                    using (var command = new SqlCommand("usp_GetTicketsWithAgent", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        await connection.OpenAsync();

                        using (var reader = await command.ExecuteReaderAsync())
                        {
                            while (await reader.ReadAsync())
                            {
                                tickets.Add(new TicketsDTO
                                {
                                    TicketId = reader.GetGuid(reader.GetOrdinal("TicketId")),
                                    TicketTitle = reader.GetString(reader.GetOrdinal("TicketTitle")),
                                    TicketDescription = reader.GetString(reader.GetOrdinal("TicketDescription")),
                                    StatusId = reader.GetInt32(reader.GetOrdinal("StatusId")),
                                    AgentId = reader.GetGuid(reader.GetOrdinal("AgentId")),
                                    AgentName = reader.GetString(reader.GetOrdinal("AgentName"))
                                });
                            }
                        }
                    }
                }
                return tickets;
            }
            catch (Exception)
            {

                throw;
            }

        }

        public async Task<bool> CreateTicketAsync(TicketsDTO ticket)
        {
            try
            {
                using SqlConnection conn = new(_connectionString);
                using SqlCommand cmd = new("usp_CreateTicket", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@TicketTitle", ticket.TicketTitle);
                cmd.Parameters.AddWithValue("@TicketDescription", ticket.TicketDescription);
                cmd.Parameters.AddWithValue("@StatusId", ticket.StatusId);
                cmd.Parameters.AddWithValue("@UserId", ticket.CreatedBy);

                await conn.OpenAsync();
                using SqlDataReader reader = await cmd.ExecuteReaderAsync();
                return reader.Read() && reader.GetInt32(0) > 0;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        public async Task<bool> UpdateTicketAsync(TicketsDTO ticket)
        {
            try
            {
                using SqlConnection conn = new(_connectionString);
                using SqlCommand cmd = new("usp_UpdateTicket", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@TicketId", ticket.TicketId);
                cmd.Parameters.AddWithValue("@TicketTitle", ticket.TicketTitle);
                cmd.Parameters.AddWithValue("@TicketDescription", ticket.TicketDescription);
                cmd.Parameters.AddWithValue("@StatusId", ticket.StatusId);
                cmd.Parameters.AddWithValue("@UserId", ticket.CreatedBy);

                await conn.OpenAsync();
                using SqlDataReader reader = await cmd.ExecuteReaderAsync();
                var result = reader.Read() && reader.GetInt32(0) > 0;
                return result;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        public async Task<bool> DeleteTicketAsync(Guid ticketId)
        {
            try
            {
                using SqlConnection conn = new(_connectionString);
                using SqlCommand cmd = new("usp_DeleteTicket", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@TicketId", ticketId);

                await conn.OpenAsync();
                int rowsAffected = await cmd.ExecuteNonQueryAsync();
                return rowsAffected > -2;
            }
            catch (Exception ex)
            {

                throw;
            }
        }

    }
}
