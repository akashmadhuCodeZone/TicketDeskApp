using TicketDesk.Core.Interfaces.Registeration;
using TicketDesk.DAL.Domain;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Customer;

namespace TicketDesk.Core.Services.Registeration
{
    public class RegisterationService : IRegisterationService
    {

        private readonly IRegisterationDataAccess _registerationDataAccess;
        public RegisterationService(IRegisterationDataAccess registerationDataAccess)
        {
            _registerationDataAccess = registerationDataAccess;
        }


        public async Task<bool> RegisterUserAsync(CustomerDTO customerDTO)
        {
            try
            {
                return await _registerationDataAccess.RegisterUserAsync(customerDTO);
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
