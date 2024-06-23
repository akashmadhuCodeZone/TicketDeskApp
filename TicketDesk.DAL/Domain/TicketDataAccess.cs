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
                        TicketTypeId = (int)reader["TicketTypeId"],
                        DepartmentId = (int)reader["DepartmentId"],
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
                        TicketTypeId = (int)reader["TicketTypeId"],
                        DepartmentId = (int)reader["DepartmentId"],
                        TicketTitle = reader["TicketTitle"].ToString(),
                        TicketDescription = reader["TicketDescription"].ToString(),
                        StatusId = (int)reader["StatusId"],
                        CreatedOn = (DateTime)reader["CreatedOn"],
                        CreatedBy = (Guid)reader["CreatedBy"],
                        ModifiedOn = reader["ModifiedOn"] as DateTime?,
                        ModifiedBy = reader["ModifiedBy"] as Guid?
                    };
                }
                return null;
            }
            catch(Exception ex)
            {

                throw ex;
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
                cmd.Parameters.AddWithValue("@TicketTypeId", ticket.TicketTypeId);
                cmd.Parameters.AddWithValue("@DepartmentId", ticket.DepartmentId);
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
                cmd.Parameters.AddWithValue("@TicketTypeId", ticket.TicketTypeId);
                cmd.Parameters.AddWithValue("@DepartmentId", ticket.DepartmentId);
                cmd.Parameters.AddWithValue("@TicketTitle", ticket.TicketTitle);
                cmd.Parameters.AddWithValue("@TicketDescription", ticket.TicketDescription);
                cmd.Parameters.AddWithValue("@StatusId", ticket.StatusId);
                cmd.Parameters.AddWithValue("@UserId", ticket.ModifiedBy);

                await conn.OpenAsync();
                using SqlDataReader reader = await cmd.ExecuteReaderAsync();
                var result =  reader.Read() && reader.GetInt32(0) > 0;
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
                return rowsAffected > 0;
            }
            catch (Exception ex)
            {

                throw;
            }
        }

    }
}
