using System.Threading.Tasks;
using TicketDesk.Core.Interfaces.Registeration;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Customer;

namespace TicketDesk.Core.Services.Registeration
{
    public class RegisterationService : IRegisterationService
    {
        private readonly IRegisterationDataAccess _registerationDataAccess;

        public RegisterationService(IRegisterationDataAccess registerationDataAccess) =>
            _registerationDataAccess = registerationDataAccess;

        public Task<bool> RegisterUserAsync(CustomerDTO customerDTO) =>
            _registerationDataAccess.RegisterUserAsync(customerDTO);
    }
}
