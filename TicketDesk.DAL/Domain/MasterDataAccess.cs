using System.Data;
using System.Data.SqlClient;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.MasterData;
using TicketDesk.Utility.Logger;

namespace TicketDesk.DAL.Domain
{
    public class MasterDataAccess : IMasterDataAccess
    {
        private readonly string _connectionString;
        private readonly Logger _logger;

        public MasterDataAccess(string connectionString, Logger logger) =>
            (_connectionString, _logger) = (connectionString, logger);

        public async Task<MasterDataDTO> GetAllMasterDataAsync()
        {
            _logger.LogInformation("Fetching all master data.");
            var masterData = new MasterDataDTO
            {
                Countries = new List<MasterDataDTO.CountryDto>(),
                Genders = new List<MasterDataDTO.GenderDto>(),
                Departments = new List<MasterDataDTO.DepartmentDto>(),
                Roles = new List<MasterDataDTO.RoleDto>(),
                Statuses = new List<MasterDataDTO.StatusDto>(),
                TicketTypes = new List<MasterDataDTO.TicketTypeDto>()
            };

            try
            {
                using var connection = new SqlConnection(_connectionString);
                using var command = new SqlCommand("usp_GetMasterData", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                await connection.OpenAsync();
                using var reader = await command.ExecuteReaderAsync();

                masterData.Countries = await ReadMasterDataAsync<MasterDataDTO.CountryDto>(reader);
                await reader.NextResultAsync();
                masterData.Genders = await ReadMasterDataAsync<MasterDataDTO.GenderDto>(reader);
                await reader.NextResultAsync();
                masterData.Departments = await ReadMasterDataAsync<MasterDataDTO.DepartmentDto>(reader);
                await reader.NextResultAsync();
                masterData.Roles = await ReadMasterDataAsync<MasterDataDTO.RoleDto>(reader);
                await reader.NextResultAsync();
                masterData.Statuses = await ReadMasterDataAsync<MasterDataDTO.StatusDto>(reader);
                await reader.NextResultAsync();
                masterData.TicketTypes = await ReadMasterDataAsync<MasterDataDTO.TicketTypeDto>(reader);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex.Message, ex.StackTrace, "Error fetching master data");
                throw;
            }

            return masterData;
        }

        private static async Task<List<T>> ReadMasterDataAsync<T>(SqlDataReader reader) where T : new()
        {
            var list = new List<T>();
            var properties = typeof(T).GetProperties();

            while (await reader.ReadAsync())
            {
                var item = new T();
                foreach (var property in properties)
                {
                    var columnName = property.Name;
                    if (!reader.IsDBNull(reader.GetOrdinal(columnName)))
                    {
                        property.SetValue(item, reader[columnName]);
                    }
                }
                list.Add(item);
            }
            return list;
        }
    }
}
