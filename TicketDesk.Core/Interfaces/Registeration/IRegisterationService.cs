using TicketDesk.DTO.Registeration;
using TicketDesk.DTO.User;

namespace TicketDesk.Core.Interfaces.Registeration
{
    public interface IRegisterationService
    {
        Task<bool> RegisterUserAsync(RegisterationDTO registerationDto);

    }
}
