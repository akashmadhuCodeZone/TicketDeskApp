using TicketDesk.DTO.Customer;

namespace TicketDesk.Core.Interfaces.Registeration
{
    public interface IRegisterationService
    {
        Task<bool> RegisterUserAsync(CustomerDTO customerDTO);

    }
}
