using TicketDesk.DTO.Customer;
using TicketDesk.DTO.Registeration;

namespace TicketDesk.Core.Interfaces.Customer
{
    public interface IAgentService
    {
        Task<bool> CreateAgentAsync(RegisterationDTO registeration);
    }
}
