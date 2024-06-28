using System.Data;
using System.Data.SqlClient;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.User;

namespace TicketDesk.DAL.Domain
{
    public class RegisterationDataAccess
    {
        private readonly string _connectionString;

        public RegisterationDataAccess(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<bool> RegisterUserAsync(CustomerDTO customerDTO)
        {
            using SqlConnection conn = new SqlConnection(_connectionString);
            try
            {
                await conn.OpenAsync();
                return await IsUserRegistered(customerDTO.User.EmailAddress, customerDTO.User.PhoneNumber)
                    ? false
                    : await ExecuteRegisterUserAsync(conn, customerDTO);
            }
            catch (Exception ex)
            {
                // Optionally: Add logging here
                throw ex;
            }
            finally
            {
                await conn.CloseAsync();
            }
        }

        private async Task<bool> ExecuteRegisterUserAsync(SqlConnection conn, CustomerDTO customerDTO)
        {
            using SqlCommand cmd = new SqlCommand("usp_RegisterUser", conn)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@FirstName", customerDTO.User.FirstName);
            cmd.Parameters.AddWithValue("@LastName", customerDTO.User.LastName);
            cmd.Parameters.AddWithValue("@Email", customerDTO.User.EmailAddress);
            cmd.Parameters.AddWithValue("@PhoneNumber", customerDTO.User.PhoneNumber);
            cmd.Parameters.AddWithValue("@Password", customerDTO.User.Password.Encrypt()); // Encrypt the password
            cmd.Parameters.AddWithValue("@RoleId", customerDTO.User.RoleId);

            using SqlDataReader reader = await cmd.ExecuteReaderAsync();
            return reader.Read() && reader.GetInt32(0) > 0;
        }

        private async Task<bool> IsUserRegistered(string email, long phoneNumber)
        {
            using SqlConnection conn = new SqlConnection(_connectionString);
            using SqlCommand cmd = new SqlCommand("SELECT COUNT(1) FROM [dbo].[Users] WHERE EmailAddress = @Email OR PhoneNumber = @PhoneNumber", conn)
            {
                CommandType = CommandType.Text
            };

            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);

            await conn.OpenAsync();
            int count = (int)await cmd.ExecuteScalarAsync();
            await conn.CloseAsync();
            return count > 0;
        }
    }
}
