using Microsoft.AspNetCore.Identity.Data;
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
        private readonly JWTTokenGenrator _jWTTokenGenrator;
        public LoginController(ILoginService loginService,JWTTokenGenrator jWTTokenGenrator)
        {
            _loginService = loginService;
            _jWTTokenGenrator = jWTTokenGenrator;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDTO loginDTO)
        {
            return (loginDTO == null || string.IsNullOrEmpty(loginDTO.Email) || string.IsNullOrEmpty(loginDTO.Password)) ?
                BadRequest("Username and password must be provided.") :
                (await _loginService.LoginAsync(loginDTO) is var user && user == null) ?
                    Unauthorized("Invalid username or password.") :
                    Ok(new { Token = _jWTTokenGenrator.GenerateToken(user.UserId.ToString(), user.Email, user.RoleName) });
        }



    }
}
