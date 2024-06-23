using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.Core.Interfaces.Customer;
using TicketDesk.DAL.Domain;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.Registeration;

namespace TicketDesk.Core.Services.Customer
{
    public class AgentService : IAgentService
    {
		private readonly RegisterationDataAccess _registerationDataAccess;
        public AgentService(RegisterationDataAccess registerationDataAccess)
        {
            _registerationDataAccess = registerationDataAccess;
        }
        public async Task<bool> CreateAgentAsync(RegisterationDTO registeration)
        {
			try
			{
				return await _registerationDataAccess.RegisterUserAsync(registeration);
			}
			catch (Exception ex)
			{

				throw;
			}
        }
    }
}
