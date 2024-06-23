using System.Data;
using System.Data.SqlClient;
using TicketDesk.DTO.Registeration;

namespace TicketDesk.DAL.Domain
{
    public class RegisterationDataAccess
    {
        private readonly string _connectionString;

        public RegisterationDataAccess(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<bool> RegisterUserAsync(RegisterationDTO registeration)
        {
            using SqlConnection conn = new SqlConnection(_connectionString);
            try
            {
                await conn.OpenAsync();
                return await IsUserRegistered(registeration.EmailAddress, registeration.PhoneNumber)
                    ? false
                    : await ExecuteRegisterUserAsync(conn, registeration);
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

        private async Task<bool> ExecuteRegisterUserAsync(SqlConnection conn, RegisterationDTO registeration)
        {
            using SqlCommand cmd = new SqlCommand("usp_RegisterUser", conn)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@FirstName", registeration.FirstName);
            cmd.Parameters.AddWithValue("@LastName", registeration.LastName);
            cmd.Parameters.AddWithValue("@Email", registeration.EmailAddress);
            cmd.Parameters.AddWithValue("@PhoneNumber", registeration.PhoneNumber);
            cmd.Parameters.AddWithValue("@Password", registeration.Password.Encrypt()); // Encrypt the password
            cmd.Parameters.AddWithValue("@RoleId", registeration.RoleId);

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
