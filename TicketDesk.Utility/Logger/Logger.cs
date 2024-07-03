using System.Data;
using System.Data.SqlClient;

namespace TicketDesk.Utility.Logger
{
    public class Logger
    {
        private readonly string _connectionString;

        public Logger(string connectionString) => _connectionString = connectionString;

        public void LogError(string errorDescription, string stackTrace, string traceDescription) =>
            Log("Error", errorDescription, stackTrace, traceDescription);

        public void LogInformation(string traceDescription) => Log("Information", null, null, traceDescription);

        private void Log(string logLevel, string errorDescription, string stackTrace, string traceDescription)
        {
            try
            {
                const string storedProcedure = "sp_InsertApplicationLog";

                using var connection = new SqlConnection(_connectionString);
                using var command = new SqlCommand(storedProcedure, connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                command.Parameters.Add(new SqlParameter("@LogLevel", logLevel));
                command.Parameters.Add(new SqlParameter("@ErrorDescription", (object)errorDescription ?? DBNull.Value));
                command.Parameters.Add(new SqlParameter("@StackTrace", (object)stackTrace ?? DBNull.Value));
                command.Parameters.Add(new SqlParameter("@TraceDescription", traceDescription));
                connection.Open();
                command.ExecuteNonQuery();
            }
            catch (Exception ex)
            {

                throw;
            }
            
        }
    }
}
