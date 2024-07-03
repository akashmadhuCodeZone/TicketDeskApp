using System.Data;
using System.Data.SqlClient;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.Tickets;
using TicketDesk.DTO.User;
using TicketDesk.Utility.Logger;

namespace TicketDesk.DAL.Domain
{
    public class AgentDataAccess : IAgentDataAccess
    {
        private readonly string _connectionString;
        private readonly Logger _logger;

        public AgentDataAccess(string connectionString, Logger logger) =>
            (_connectionString, _logger) = (connectionString, logger);

        public async Task<IEnumerable<AgentDTO>> GetAllAgentsAsync()
        {
            _logger.LogInformation("Fetching all agents.");
            var agents = new List<AgentDTO>();

            try
            {
                using var connection = new SqlConnection(_connectionString);
                using var command = new SqlCommand("usp_GetAllAgents", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                await connection.OpenAsync();
                using var reader = await command.ExecuteReaderAsync();

                while (await reader.ReadAsync())
                {
                    agents.Add(new AgentDTO
                    {
                        AgentId = reader["AgentId"] as Guid?,
                        User = new UserDTO
                        {
                            UserId = (Guid)reader["UserId"],
                            FirstName = reader["FirstName"].ToString(),
                            LastName = reader["LastName"].ToString(),
                            PhoneNumber = (long)reader["PhoneNumber"],
                            EmailAddress = reader["EmailAddress"].ToString(),
                            Password = reader["Password"].ToString(),
                            CreatedOn = reader["CreatedOn"] as DateTime?,
                            CreatedBy = reader["CreatedBy"] as Guid?,
                            ModifiedOn = reader["ModifiedOn"] as DateTime?,
                            ModifiedBy = reader["ModifiedBy"] as Guid?
                        },
                        CreatedOn = reader["CreatedOn"] as DateTime?,
                        CreatedBy = reader["CreatedBy"] as Guid?,
                        ModifiedOn = reader["ModifiedOn"] as DateTime?,
                        ModifiedBy = reader["ModifiedBy"] as Guid?
                    });
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, "Error fetching all agents");
                throw;
            }

            return agents;
        }

        public async Task<AgentDTO> GetAgentByIdAsync(Guid agentId)
        {
            _logger.LogInformation($"Fetching agent by ID: {agentId}");
            AgentDTO agent = null;

            try
            {
                using var connection = new SqlConnection(_connectionString);
                using var command = new SqlCommand("usp_GetAgentById", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.Add(new SqlParameter("@AgentId", agentId));

                await connection.OpenAsync();
                using var reader = await command.ExecuteReaderAsync();

                if (await reader.ReadAsync())
                {
                    agent = new AgentDTO
                    {
                        AgentId = reader["AgentId"] as Guid?,
                        User = new UserDTO
                        {
                            UserId = (Guid)reader["UserId"],
                            FirstName = reader["FirstName"].ToString(),
                            LastName = reader["LastName"].ToString(),
                            PhoneNumber = (long)reader["PhoneNumber"],
                            EmailAddress = reader["EmailAddress"].ToString(),
                            Password = reader["Password"].ToString(),
                            CreatedOn = reader["CreatedOn"] as DateTime?,
                            CreatedBy = reader["CreatedBy"] as Guid?,
                            ModifiedOn = reader["ModifiedOn"] as DateTime?,
                            ModifiedBy = reader["ModifiedBy"] as Guid?
                        },
                        CreatedOn = reader["CreatedOn"] as DateTime?,
                        CreatedBy = reader["CreatedBy"] as Guid?,
                        ModifiedOn = reader["ModifiedOn"] as DateTime?,
                        ModifiedBy = reader["ModifiedBy"] as Guid?
                    };
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error fetching agent by ID: {agentId}");
                throw;
            }

            return agent;
        }

        public async Task<bool> CreateAgentAsync(AgentDTO agentDTO)
        {
            _logger.LogInformation("Creating new agent.");
            try
            {
                using var connection = new SqlConnection(_connectionString);
                if (!await IsUserRegistered(agentDTO.User.EmailAddress, agentDTO.User.PhoneNumber))
                {
                    using var command = new SqlCommand("usp_CreateAgent", connection)
                    {
                        CommandType = CommandType.StoredProcedure
                    };
                    command.Parameters.Add(new SqlParameter("@FirstName", agentDTO.User.FirstName));
                    command.Parameters.Add(new SqlParameter("@LastName", agentDTO.User.LastName));
                    command.Parameters.Add(new SqlParameter("@PhoneNumber", agentDTO.User.PhoneNumber));
                    command.Parameters.Add(new SqlParameter("@Email", agentDTO.User.EmailAddress));
                    command.Parameters.Add(new SqlParameter("@Password", agentDTO.User.Password.Encrypt()));

                    await connection.OpenAsync();
                    var result = await command.ExecuteNonQueryAsync();
                    return result > -2;
                }
                return false;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, "Error creating agent");
                throw;
            }
        }

        private async Task<bool> IsUserRegistered(string email, long phoneNumber)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("SELECT COUNT(1) FROM [dbo].[Users] WHERE EmailAddress = @Email OR PhoneNumber = @PhoneNumber", conn)
                {
                    CommandType = CommandType.Text
                };

                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);

                await conn.OpenAsync();
                int count = (int)await cmd.ExecuteScalarAsync();
                return count > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, "Error checking if user is registered");
                throw;
            }
        }

        public async Task<bool> UpdateAgentAsync(AgentDTO agentDTO)
        {
            _logger.LogInformation($"Updating agent ID: {agentDTO.AgentId}");
            try
            {
                using var connection = new SqlConnection(_connectionString);
                using var command = new SqlCommand("usp_UpdateAgent", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.Add(new SqlParameter("@AgentId", agentDTO.AgentId));
                command.Parameters.Add(new SqlParameter("@FirstName", agentDTO.User.FirstName));
                command.Parameters.Add(new SqlParameter("@LastName", agentDTO.User.LastName));
                command.Parameters.Add(new SqlParameter("@PhoneNumber", agentDTO.User.PhoneNumber));
                command.Parameters.Add(new SqlParameter("@EmailAddress", agentDTO.User.EmailAddress));
                command.Parameters.Add(new SqlParameter("@Password", agentDTO.User.Password));

                await connection.OpenAsync();
                var result = await command.ExecuteNonQueryAsync();
                return result > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error updating agent ID: {agentDTO.AgentId}");
                throw;
            }
        }

        public async Task<bool> DeleteAgentAsync(Guid agentId)
        {
            _logger.LogInformation($"Deleting agent ID: {agentId}");
            try
            {
                using var connection = new SqlConnection(_connectionString);
                using var command = new SqlCommand("usp_DeleteAgent", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.Add(new SqlParameter("@AgentId", agentId));

                await connection.OpenAsync();
                var result = await command.ExecuteNonQueryAsync();
                return result > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error deleting agent ID: {agentId}");
                throw;
            }
        }

        public async Task<(IEnumerable<AgentDTO> Data, int TotalRecords)> GetAgentsPaginatedAsync(int page, int size)
        {
            _logger.LogInformation($"Fetching agents paginated. Page: {page}, Size: {size}");
            var agents = new List<AgentDTO>();
            int totalRecords = 0;

            try
            {
                using var connection = new SqlConnection(_connectionString);
                using var command = new SqlCommand("usp_GetAgentsPaginated", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.Add(new SqlParameter("@Page", page));
                command.Parameters.Add(new SqlParameter("@Size", size));

                await connection.OpenAsync();
                using var reader = await command.ExecuteReaderAsync();

                if (reader.HasRows)
                {
                    while (await reader.ReadAsync())
                    {
                        agents.Add(new AgentDTO
                        {
                            AgentId = reader["AgentId"] as Guid?,
                            User = new UserDTO
                            {
                                UserId = (Guid)reader["UserId"],
                                FirstName = reader["FirstName"].ToString(),
                                LastName = reader["LastName"].ToString(),
                                PhoneNumber = (long)reader["PhoneNumber"],
                                EmailAddress = reader["EmailAddress"].ToString(),
                                Password = reader["Password"].ToString(),
                                CreatedOn = reader["CreatedOn"] as DateTime?,
                                CreatedBy = reader["CreatedBy"] as Guid?,
                                ModifiedOn = reader["ModifiedOn"] as DateTime?,
                                ModifiedBy = reader["ModifiedBy"] as Guid?
                            },
                            CreatedOn = reader["CreatedOn"] as DateTime?,
                            CreatedBy = reader["CreatedBy"] as Guid?,
                            ModifiedOn = reader["ModifiedOn"] as DateTime?,
                            ModifiedBy = reader["ModifiedBy"] as Guid?
                        });
                    }

                    if (await reader.NextResultAsync() && await reader.ReadAsync())
                    {
                        totalRecords = (int)reader["TotalRecords"];
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, "Error fetching paginated agents");
                throw;
            }

            return (agents, totalRecords);
        }

        public async Task<bool> InsertAgentTicketMappingAsync(Guid agentId, Guid ticketId, Guid createdBy)
        {
            _logger.LogInformation($"Inserting agent-ticket mapping. Agent ID: {agentId}, Ticket ID: {ticketId}");
            try
            {
                using var connection = new SqlConnection(_connectionString);
                using var command = new SqlCommand("usp_UpsertAgentTicketMapping", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.Add(new SqlParameter("@AgentId", agentId));
                command.Parameters.Add(new SqlParameter("@TicketId", ticketId));
                command.Parameters.Add(new SqlParameter("@CreatedBy", createdBy));

                await connection.OpenAsync();
                var result = await command.ExecuteNonQueryAsync();
                return result > 0;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, "Error inserting agent-ticket mapping");
                throw;
            }
        }

        public async Task<IEnumerable<TicketsDTO>> GetTicketsByAgentAsync(Guid agentId)
        {
            _logger.LogInformation($"Fetching tickets by agent ID: {agentId}");
            var tickets = new List<TicketsDTO>();

            try
            {
                using var connection = new SqlConnection(_connectionString);
                using var command = new SqlCommand("usp_GetTicketsByAgent", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };
                command.Parameters.Add(new SqlParameter("@UserId", agentId));

                await connection.OpenAsync();
                using var reader = await command.ExecuteReaderAsync();

                while (await reader.ReadAsync())
                {
                    tickets.Add(new TicketsDTO
                    {
                        TicketId = reader["TicketId"] as Guid?,
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
                _logger.LogError(ex.Message, ex.StackTrace, $"Error fetching tickets by agent ID: {agentId}");
                throw;
            }

            return tickets;
        }
    }
}
