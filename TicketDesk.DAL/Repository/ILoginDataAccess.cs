using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.Login;

namespace TicketDesk.DAL.Repository
{
    public interface ILoginDataAccess
    {
        public Task<LoginResponseDTO> ValidateUserAsync(LoginDTO login);
    }
}
