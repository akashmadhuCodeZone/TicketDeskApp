using Microsoft.Extensions.Configuration;
using TicketDesk.Core.Interfaces.Login;
using TicketDesk.DAL.Domain;
using TicketDesk.DTO;
using TicketDesk.DTO.Login;


namespace TicketDesk.Core.Services.Login
{
    public class LoginService : ILoginService
    {
        private readonly IConfiguration _configuration;
        private readonly LoginDataAccess _loginDataAccess;

        public LoginService(IConfiguration configuration,LoginDataAccess loginDataAccess)
        {
            _configuration = configuration;
            _loginDataAccess = loginDataAccess;
        }

        public async Task<LoginResponseDTO> LoginAsync(LoginDTO login)
        {
            try
            {
                return await  _loginDataAccess.ValidateUserAsync(login);
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}
