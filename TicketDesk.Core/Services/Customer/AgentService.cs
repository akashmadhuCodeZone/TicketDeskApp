using TicketDesk.Core.Interfaces.Customer;
using TicketDesk.DAL.Domain;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.User;

namespace TicketDesk.Core.Services.Customer
{
    public class AgentService : IAgentService
    {
		private readonly RegisterationDataAccess _registerationDataAccess;
        public AgentService(RegisterationDataAccess registerationDataAccess)
        {
            _registerationDataAccess = registerationDataAccess;
        }
        public async Task<bool> CreateAgentAsync(CustomerDTO customerDTO)
        {
			try
			{
				return await _registerationDataAccess.RegisterUserAsync(customerDTO);
			}
			catch (Exception ex)
			{

				throw;
			}
        }
    }
}
