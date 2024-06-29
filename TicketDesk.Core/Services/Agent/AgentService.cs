using TicketDesk.Core.Interfaces.Agent;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.Core.Services.Agent
{
    public class AgentService : IAgentService
    {
        private readonly IAgentDataAccess _agentDataAccess;

        public AgentService(IAgentDataAccess agentDataAccess)
        {
            _agentDataAccess = agentDataAccess;
        }

        public async Task<IEnumerable<AgentDTO>> GetAllAgentsAsync()
        {
            try
            {

                return await _agentDataAccess.GetAllAgentsAsync();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<AgentDTO> GetAgentByIdAsync(Guid agentId)
        {
            try
            {
                return await _agentDataAccess.GetAgentByIdAsync(agentId);

            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<bool> CreateAgentAsync(AgentDTO agentDTO)
        {
            try
            {
                return await _agentDataAccess.CreateAgentAsync(agentDTO);

            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<bool> UpdateAgentAsync(AgentDTO agentDTO)
        {
            try
            {

                return await _agentDataAccess.UpdateAgentAsync(agentDTO);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<bool> DeleteAgentAsync(Guid agentId)
        {
            try
            {

                return await _agentDataAccess.DeleteAgentAsync(agentId);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<(IEnumerable<AgentDTO> Data, int TotalRecords)> GetAgentsPaginatedAsync(int page, int size)
        {
            try
            {

                return await _agentDataAccess.GetAgentsPaginatedAsync(page, size);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<bool> InsertAgentTicketMappingAsync(Guid agentId, Guid ticketId, Guid createdBy)
        {
            return await _agentDataAccess.InsertAgentTicketMappingAsync(agentId, ticketId, createdBy);
        }

        public async Task<IEnumerable<TicketsDTO>> GetTicketsByAgentAsync(Guid agentId)
        {
            return await _agentDataAccess.GetTicketsByAgentAsync(agentId);
        }
    }
}
