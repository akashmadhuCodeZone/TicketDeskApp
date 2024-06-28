using TicketDesk.DTO.Customer;
using TicketDesk.DTO.User;

namespace TicketDesk.Core.Interfaces.Customer
{
    public interface IAgentService
    {
        Task<bool> CreateAgentAsync(CustomerDTO customerDTO);
    }
}
