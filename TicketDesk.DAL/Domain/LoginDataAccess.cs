using System.Data;
using System.Data.SqlClient;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Login;
using TicketDesk.Utility.Logger;

namespace TicketDesk.DAL.Domain
{
    public class LoginDataAccess : ILoginDataAccess
    {
        private readonly string _connectionString;
        private readonly Logger _logger;

        public LoginDataAccess(string connectionString, Logger logger) =>
            (_connectionString, _logger) = (connectionString, logger);

        public async Task<LoginResponseDTO> ValidateUserAsync(LoginDTO login)
        {
            _logger.LogInformation($"Validating user with email: {login.Email}");
            LoginResponseDTO loginResponseDTO = null;

            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_ValidateUser", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@Email", login.Email);
                cmd.Parameters.AddWithValue("@Password", login.Password.Encrypt());

                await conn.OpenAsync();
                using var reader = await cmd.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    loginResponseDTO = new LoginResponseDTO
                    {
                        UserId = reader["UserId"] as Guid?,
                        FirstName = reader["FirstName"].ToString(),
                        LastName = reader["LastName"].ToString(),
                        Email = reader["EmailAddress"].ToString(),
                        RoleId = Convert.ToInt32(reader["RoleId"]),
                        RoleName = reader["RoleName"].ToString(),
                        Result = true
                    };
                }
                else
                {
                    loginResponseDTO = new LoginResponseDTO
                    {
                        Email = login.Email,
                        Result = false
                    };
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error validating user with email: {login.Email}");
                throw;
            }

            return loginResponseDTO;
        }
    }
}
