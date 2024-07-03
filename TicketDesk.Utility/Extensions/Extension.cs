using Microsoft.AspNetCore.Mvc;

public static class ControllerExtensions
{
    public static async Task<IActionResult> ExecuteAsync<T>(this ControllerBase controller, Func<Task<T>> action, string notFoundMessage = null, string successMessage = null, string errorMessage = null)
    {
        try
        {
            var result = await action();
            if (result == null && notFoundMessage != null)
                return controller.NotFound(notFoundMessage);

            return result switch
            {
                bool success when !success => controller.BadRequest(errorMessage ?? "Operation failed"),
                bool success when success => controller.Ok(),
                _ => controller.Ok(result)
            };
        }
        catch (Exception ex)
        {
            return controller.StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }

    public static IActionResult ValidateDto<T>(this ControllerBase controller, T dto)
    {
        if (dto == null)
            return controller.BadRequest($"Invalid {typeof(T).Name} data.");
        return null;
    }

}
