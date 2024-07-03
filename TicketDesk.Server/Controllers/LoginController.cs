using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces.Login;
using TicketDesk.DTO.Login;
using TicketDesk.Utility.Security;

namespace TicketDesk.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly ILoginService _loginService;
        private readonly JWTTokenGenerator _jWTTokenGenerator;

        public LoginController(ILoginService loginService, JWTTokenGenerator jWTTokenGenerator) =>
            (_loginService, _jWTTokenGenerator) = (loginService, jWTTokenGenerator);

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDTO loginDTO) =>
            this.ValidateDto(loginDTO) ??
            (await _loginService.LoginAsync(loginDTO) is var user && user != null
                ? Ok(new { Token = await _jWTTokenGenerator.GenerateTokenAsync(user.UserId.ToString(), user.Email, user.RoleName) })
                : Unauthorized("Invalid username or password."));
    }
}


