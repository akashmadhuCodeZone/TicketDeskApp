using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Runtime.InteropServices;
using TicketDesk.Core.Interfaces.Registeration;
using TicketDesk.DTO.Registeration;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace TicketDesk.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegistrationController : ControllerBase
    {
        private readonly IRegisterationService _registerationService;

        public RegistrationController(IRegisterationService registerationService)
        {
            _registerationService = registerationService;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterationDTO registerationDto)
        {
            return registerationDto == null ? BadRequest("Invalid user registration data.") :
            (await _registerationService.RegisterUserAsync(registerationDto) is var response) ?
            Ok(response) :
            BadRequest(response);
        }



    }
}
