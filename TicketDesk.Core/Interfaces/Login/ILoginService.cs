using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.Login;

namespace TicketDesk.Core.Interfaces.Login
{
    public interface ILoginService
    {
        Task<LoginResponseDTO> LoginAsync(LoginDTO login);
    }
}
