using System.Data.SqlClient;
using TicketDesk.DTO;

namespace TicketDesk.Utility.Extensions
{
    public static class Extensions
    {
        public static Response SuccessResult(this object data, string message = "Success")
        {
            return new Response
            {
                Data = data,
                IsSuccess = true,
                Message = message
            };
        }

        public static Response FailedResult(this object data, string message = "Failed")
        {
            return new Response
            {
                Data = data,
                IsSuccess = false,
                Message = message
            };
        }
        public static bool HasColumn(this SqlDataReader reader, string columnName)
        {
            for (int i = 0; i < reader.FieldCount; i++)
            {
                if (reader.GetName(i).Equals(columnName, StringComparison.OrdinalIgnoreCase))
                    return true;
            }
            return false;
        }

        public static bool IsDBNull(this SqlDataReader reader, string columnName)
        {
            return reader[columnName] == DBNull.Value;
        }
    }
}
