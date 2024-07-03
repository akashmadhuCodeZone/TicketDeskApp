using System.Data;
using System.Data.SqlClient;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.UserProfile;
using TicketDesk.Utility.Logger;

namespace TicketDesk.DAL.Domain
{
    public class UserProfileDataAccess : IUserProfileDataAccess
    {
        private readonly string _connectionString;
        private readonly Logger _logger;

        public UserProfileDataAccess(string connectionString, Logger logger) =>
            (_connectionString, _logger) = (connectionString, logger);

        public async Task<UserProfileDTO> GetUserProfileAsync(Guid userId)
        {
            _logger.LogInformation($"Fetching user profile for user ID: {userId}");
            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_GetUserProfile", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@UserId", userId);

                await conn.OpenAsync();
                using var reader = await cmd.ExecuteReaderAsync();
                if (await reader.ReadAsync())
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
                        PhoneNumber = (long)reader["PhoneNumber"]
                    };
                }
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error fetching user profile for user ID: {userId}");
                throw;
            }
            return null;
        }

        public async Task<UserProfileDTO> GetUserProfileByUserIdAsync(Guid userId)
        {
            _logger.LogInformation($"Fetching user profile by user ID: {userId}");
            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_GetUserProfileByUserId", conn)
                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@UserId", userId);

                await conn.OpenAsync();
                using var reader = await cmd.ExecuteReaderAsync();
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
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error fetching user profile by user ID: {userId}");
                throw;
            }
            return null;
        }

        public async Task<bool> UpdateUserProfileAsync(UserProfileDTO profile)
        {
            _logger.LogInformation($"Updating user profile ID: {profile.ProfileId}");
            try
            {
                using var conn = new SqlConnection(_connectionString);
                using var cmd = new SqlCommand("usp_UpdateUserProfile", conn)
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
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, $"Error updating user profile ID: {profile.ProfileId}");
                throw;
            }
        }
    }
}
