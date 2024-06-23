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
    }
}
