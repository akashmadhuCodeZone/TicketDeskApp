using System.Data;
using System.Data.SqlClient;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Login;

namespace TicketDesk.DAL.Domain
{
    public class LoginDataAccess:ILoginDataAccess
    {
        private readonly string _connectionString;

        public LoginDataAccess(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<LoginResponseDTO> ValidateUserAsync(LoginDTO login)
        {
            LoginResponseDTO loginResponseDTO = null;
            using SqlConnection conn = new SqlConnection(_connectionString);
            try
            {
                using SqlCommand cmd = new SqlCommand("usp_ValidateUser", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@Email", login.Email);
                cmd.Parameters.AddWithValue("@Password", login.Password.Encrypt()); // Ensure the password is hashed before comparison

                await conn.OpenAsync();
                using SqlDataReader reader = await cmd.ExecuteReaderAsync();
                if (reader.Read())
                {
                    loginResponseDTO = new LoginResponseDTO
                    {
                        UserId = reader["UserId"] as Guid?,
                        FirstName = reader["FirstName"].ToString(),
                        LastName = reader["LastName"].ToString(),
                        Email = reader["EmailAddress"].ToString(),
                        RoleId = Convert.ToInt32(reader["RoleId"]) ,
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
                return loginResponseDTO;
            }
            catch (Exception ex)
            {
                // Optionally: Add logging here
                Console.WriteLine($"Error: {ex.Message}");
                throw;
            }
            finally
            {
                await conn.CloseAsync();
            }
        }





    }
}
