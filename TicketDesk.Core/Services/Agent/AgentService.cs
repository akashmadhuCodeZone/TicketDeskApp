using TicketDesk.Core.Interfaces.Agent;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.Core.Services.Agent
{
    public class AgentService : IAgentService
    {
        private readonly IAgentDataAccess _agentDataAccess;

        public AgentService(IAgentDataAccess agentDataAccess) => _agentDataAccess = agentDataAccess;

        public Task<IEnumerable<AgentDTO>> GetAllAgentsAsync() =>
            _agentDataAccess.GetAllAgentsAsync();

        public Task<AgentDTO> GetAgentByIdAsync(Guid agentId) =>
            _agentDataAccess.GetAgentByIdAsync(agentId);

        public Task<bool> CreateAgentAsync(AgentDTO agentDTO) =>
            _agentDataAccess.CreateAgentAsync(agentDTO);

        public Task<bool> UpdateAgentAsync(AgentDTO agentDTO) =>
            _agentDataAccess.UpdateAgentAsync(agentDTO);

        public Task<bool> DeleteAgentAsync(Guid agentId) =>
            _agentDataAccess.DeleteAgentAsync(agentId);

        public Task<(IEnumerable<AgentDTO> Data, int TotalRecords)> GetAgentsPaginatedAsync(int page, int size) =>
            _agentDataAccess.GetAgentsPaginatedAsync(page, size);

        public Task<bool> InsertAgentTicketMappingAsync(Guid agentId, Guid ticketId, Guid createdBy) =>
            _agentDataAccess.InsertAgentTicketMappingAsync(agentId, ticketId, createdBy);

        public Task<IEnumerable<TicketsDTO>> GetTicketsByAgentAsync(Guid agentId) =>
            _agentDataAccess.GetTicketsByAgentAsync(agentId);
    }
}
