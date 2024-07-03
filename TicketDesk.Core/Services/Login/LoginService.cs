using Microsoft.Extensions.Configuration;
using TicketDesk.Core.Interfaces.Login;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Login;

namespace TicketDesk.Core.Services.Login
{
    public class LoginService : ILoginService
    {
        private readonly IConfiguration _configuration;
        private readonly ILoginDataAccess _loginDataAccess;

        public LoginService(IConfiguration configuration, ILoginDataAccess loginDataAccess) =>
            (_configuration, _loginDataAccess) = (configuration, loginDataAccess);

        public Task<LoginResponseDTO> LoginAsync(LoginDTO login) =>
            _loginDataAccess.ValidateUserAsync(login);
    }
}
