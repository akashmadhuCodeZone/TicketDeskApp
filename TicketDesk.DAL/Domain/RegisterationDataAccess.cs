using System.Data;
using System.Data.SqlClient;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.User;
using TicketDesk.Utility.Logger;

namespace TicketDesk.DAL.Domain
{
    public class RegisterationDataAccess : IRegisterationDataAccess
    {
        private readonly string _connectionString;
        private readonly Logger _logger;

        public RegisterationDataAccess(string connectionString, Logger logger) =>
            (_connectionString, _logger) = (connectionString, logger);

        public async Task<bool> RegisterUserAsync(CustomerDTO customerDTO)
        {
            _logger.LogInformation($"Registering user with email: {customerDTO.User.EmailAddress}");
            try
            {
                using var conn = new SqlConnection(_connectionString);
                await conn.OpenAsync();
                return await IsUserRegistered(customerDTO.User.EmailAddress, customerDTO.User.PhoneNumber)
                    ? false
                    : await ExecuteRegisterUserAsync(conn, customerDTO);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, "Error registering user");
                throw;
            }
        }

        private async Task<bool> ExecuteRegisterUserAsync(SqlConnection conn, CustomerDTO customerDTO)
        {
            using var cmd = new SqlCommand("usp_RegisterUser", conn)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Parameters.AddWithValue("@FirstName", customerDTO.User.FirstName);
            cmd.Parameters.AddWithValue("@LastName", customerDTO.User.LastName);
            cmd.Parameters.AddWithValue("@Email", customerDTO.User.EmailAddress);
            cmd.Parameters.AddWithValue("@PhoneNumber", customerDTO.User.PhoneNumber);
            cmd.Parameters.AddWithValue("@Password", customerDTO.User.Password.Encrypt()); // Encrypt the password
            cmd.Parameters.AddWithValue("@RoleId", customerDTO.User.RoleId);

            using var reader = await cmd.ExecuteReaderAsync();
            return reader.Read() && reader.GetInt32(0) > 0;
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
    }
}
