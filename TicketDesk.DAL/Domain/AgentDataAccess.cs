using System.Data;
using System.Data.SqlClient;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.Tickets;
using TicketDesk.DTO.User;

namespace TicketDesk.DAL.Domain
{
    public class AgentDataAccess : IAgentDataAccess
    {
        private readonly string _connectionString;

        public AgentDataAccess(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<IEnumerable<AgentDTO>> GetAllAgentsAsync()
        {
            var agents = new List<AgentDTO>();

            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = new SqlCommand("usp_GetAllAgents", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    await connection.OpenAsync();

                    using (var reader = await command.ExecuteReaderAsync())
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
                    }
                }
            }

            return agents;
        }

        public async Task<AgentDTO> GetAgentByIdAsync(Guid agentId)
        {
            AgentDTO agent = null;

            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = new SqlCommand("usp_GetAgentById", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@AgentId", agentId));

                    await connection.OpenAsync();

                    using (var reader = await command.ExecuteReaderAsync())
                    {
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
                }
            }

            return agent;
        }

        public async Task<bool> CreateAgentAsync(AgentDTO agentDTO)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    using (var command = new SqlCommand("usp_CreateAgent", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(new SqlParameter("@FirstName", agentDTO.User.FirstName));
                        command.Parameters.Add(new SqlParameter("@LastName", agentDTO.User.LastName));
                        command.Parameters.Add(new SqlParameter("@PhoneNumber", agentDTO.User.PhoneNumber));
                        command.Parameters.Add(new SqlParameter("@Email", agentDTO.User.EmailAddress));
                        command.Parameters.Add(new SqlParameter("@Password", agentDTO.User.Password));

                        await connection.OpenAsync();
                        var result = await command.ExecuteNonQueryAsync();
                        return result > 0;
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }

        }

        public async Task<bool> UpdateAgentAsync(AgentDTO agentDTO)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = new SqlCommand("usp_UpdateAgent", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
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
            }
        }

        public async Task<bool> DeleteAgentAsync(Guid agentId)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = new SqlCommand("usp_DeleteAgent", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@AgentId", agentId));

                    await connection.OpenAsync();
                    var result = await command.ExecuteNonQueryAsync();
                    return result > 0;
                }
            }
        }
        public async Task<(IEnumerable<AgentDTO> Data, int TotalRecords)> GetAgentsPaginatedAsync(int page, int size)
        {
            var agents = new List<AgentDTO>();
            int totalRecords = 0;

            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = new SqlCommand("usp_GetAgentsPaginated", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@Page", page));
                    command.Parameters.Add(new SqlParameter("@Size", size));

                    await connection.OpenAsync();

                    using (var reader = await command.ExecuteReaderAsync())
                    {
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
                }
            }

            return (agents, totalRecords);
        }

        public async Task<bool> InsertAgentTicketMappingAsync(Guid agentId, Guid ticketId, Guid createdBy)
        {
            try
            {
                using (var connection = new SqlConnection(_connectionString))
                {
                    using (var command = new SqlCommand("usp_InsertAgentTicketMapping", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(new SqlParameter("@AgentId", ticketId));
                        command.Parameters.Add(new SqlParameter("@TicketId", agentId));
                        command.Parameters.Add(new SqlParameter("@CreatedBy", createdBy));

                        await connection.OpenAsync();
                        var result = await command.ExecuteNonQueryAsync();
                        return result > 0;
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }

        }

        public async Task<IEnumerable<TicketsDTO>> GetTicketsByAgentAsync(Guid agentId)
        {
            var tickets = new List<TicketsDTO>();

            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = new SqlCommand("usp_GetTicketsByAgent", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@AgentId", agentId));

                    await connection.OpenAsync();

                    using (var reader = await command.ExecuteReaderAsync())
                    {
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
                }
            }

            return tickets;
        }
    }

}
