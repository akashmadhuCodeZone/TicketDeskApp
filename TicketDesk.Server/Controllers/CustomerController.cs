using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces.Registeration;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.User;

namespace TicketDesk.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CustomerController : ControllerBase
    {
        private readonly IRegisterationService _registerationService;

        public CustomerController(IRegisterationService registerationService)
        {
            _registerationService = registerationService;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] CustomerDTO customerDTO)
        {
            return customerDTO == null ? BadRequest("Invalid user registration data.") :
            (await _registerationService.RegisterUserAsync(customerDTO) is var response) ?
            Ok(response) :
            BadRequest(response);
        }



    }
}
