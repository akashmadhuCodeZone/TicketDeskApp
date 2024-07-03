using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces.Registeration;
using TicketDesk.DTO.Customer;

namespace TicketDesk.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerController : ControllerBase
    {
        private readonly IRegisterationService _registrationService;

        public CustomerController(IRegisterationService registrationService) => _registrationService = registrationService;

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] CustomerDTO customerDTO) =>
             this.ValidateDto(customerDTO) ?? await this.ExecuteAsync(async () => 
             await _registrationService.RegisterUserAsync(customerDTO), errorMessage: "Registration failed.");
    }
}
