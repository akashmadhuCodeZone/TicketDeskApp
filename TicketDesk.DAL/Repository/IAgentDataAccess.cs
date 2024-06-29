using TicketDesk.DTO.Customer;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.DAL.Repository
{
    public interface IAgentDataAccess
    {
        public Task<IEnumerable<AgentDTO>> GetAllAgentsAsync();
        public Task<AgentDTO> GetAgentByIdAsync(Guid agentId);
        public Task<bool> CreateAgentAsync(AgentDTO agent);
        public Task<bool> UpdateAgentAsync(AgentDTO agent);
        public Task<bool> DeleteAgentAsync(Guid agentId);
        public Task<(IEnumerable<AgentDTO> Data, int TotalRecords)> GetAgentsPaginatedAsync(int page, int size);
        public Task<bool> InsertAgentTicketMappingAsync(Guid agentId, Guid ticketId, Guid createdBy);
        public Task<IEnumerable<TicketsDTO>> GetTicketsByAgentAsync(Guid agentId);
    }

}
