using TicketDesk.Core.Interfaces.Registeration;
using TicketDesk.DAL.Domain;
using TicketDesk.DTO.Customer;

namespace TicketDesk.Core.Services.Registeration
{
    public class RegisterationService : IRegisterationService
    {

        private readonly RegisterationDataAccess _registerationDataAccess;
        public RegisterationService(RegisterationDataAccess registerationDataAccess)
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
