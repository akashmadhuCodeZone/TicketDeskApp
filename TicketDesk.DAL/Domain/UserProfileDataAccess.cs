using System.Data;
using System.Data.SqlClient;
using TicketDesk.DTO.UserProfile;

namespace TicketDesk.DAL.Domain
{
    public class UserProfileDataAccess
    {
        private readonly string _connectionString;

        public UserProfileDataAccess(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task<UserProfileDTO> GetUserProfileAsync(Guid userId)
        {
            using SqlConnection conn = new SqlConnection(_connectionString);
            try
            {
                using SqlCommand cmd = new SqlCommand("usp_GetUserProfile", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@UserId", userId);

                await conn.OpenAsync();
                using SqlDataReader reader = await cmd.ExecuteReaderAsync();
                if (reader.Read())
                {
                    return new UserProfileDTO
                    {
                        ProfileId = (Guid)reader["ProfileId"],
                        UserId = (Guid)reader["UserId"],
                        DisplayName = reader["DisplayName"]?.ToString(),
                        GenderId = reader["GenderId"] as int?,
                        CountryId = reader["CountryId"] as int?,
                        FirstName = reader["FirstName"]?.ToString(),
                        LastName = reader["LastName"]?.ToString(),
                        EmailAddress = reader["EmailAddress"]?.ToString(),
                        PhoneNumber = (long)reader["PhoneNumber"],


                    };
                }
                return null;
            }
            catch (Exception ex)
            {
                // Optionally: Add logging here
                throw;
            }
            finally
            {
                await conn.CloseAsync();
            }
        }

        public async Task<UserProfileDTO> GetUserProfileByUserIdAsync(Guid userId)
        {
            using SqlConnection conn = new SqlConnection(_connectionString);
            try
            {
                using SqlCommand cmd = new SqlCommand("usp_GetUserProfileByUserId", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@UserId", userId);

                await conn.OpenAsync();
                using SqlDataReader reader = await cmd.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    return new UserProfileDTO
                    {
                        ProfileId = (Guid)reader["ProfileId"],
                        UserId = (Guid)reader["UserId"],
                        DisplayName = reader["DisplayName"].ToString(),
                        GenderId = (int)reader["GenderId"],
                        CountryId = (int)reader["CountryId"],
                        CreatedOn = (DateTime)reader["CreatedOn"],
                        CreatedBy = (Guid)reader["CreatedBy"],
                        ModifiedOn = reader["ModifiedOn"] as DateTime?,
                        ModifiedBy = reader["ModifiedBy"] as Guid?
                    };
                }
                return null;
            }
            catch (Exception)
            {
                // Optionally: Add logging here
                throw;
            }
            finally
            {
                await conn.CloseAsync();
            }
        }

        public async Task<bool> UpdateUserProfileAsync(UserProfileDTO profile)
        {
            using SqlConnection conn = new SqlConnection(_connectionString);
            try
            {
                using SqlCommand cmd = new SqlCommand("usp_UpdateUserProfile", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };

                cmd.Parameters.AddWithValue("@ProfileId", profile.ProfileId);
                cmd.Parameters.AddWithValue("@UserId", profile.UserId);
                cmd.Parameters.AddWithValue("@DisplayName", profile.DisplayName);
                cmd.Parameters.AddWithValue("@GenderId", profile.GenderId);
                cmd.Parameters.AddWithValue("@CountryId", profile.CountryId);
                cmd.Parameters.AddWithValue("@FirstName", profile.FirstName);
                cmd.Parameters.AddWithValue("@LastName", profile.LastName);
                cmd.Parameters.AddWithValue("@Email", profile.EmailAddress);
                cmd.Parameters.AddWithValue("@PhoneNumber", profile.PhoneNumber);

                await conn.OpenAsync();
                int rowsAffected = await cmd.ExecuteNonQueryAsync();
                return rowsAffected > 0;
            }
            catch (Exception)
            {
                // Optionally: Add logging here
                throw;
            }
            finally
            {
                await conn.CloseAsync();
            }
        }

    }
}
