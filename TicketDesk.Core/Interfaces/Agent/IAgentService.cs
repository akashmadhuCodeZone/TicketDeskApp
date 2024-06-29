using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.Core.Interfaces.Agent
{
    public interface IAgentService
    {
        public Task<IEnumerable<AgentDTO>> GetAllAgentsAsync();
        public Task<AgentDTO> GetAgentByIdAsync(Guid agentId);
        public Task<bool> CreateAgentAsync(AgentDTO agentDTO);
        public Task<bool> UpdateAgentAsync(AgentDTO agentDTO);
        public Task<bool> DeleteAgentAsync(Guid agentId);
        public Task<(IEnumerable<AgentDTO> Data, int TotalRecords)> GetAgentsPaginatedAsync(int page, int size);
        Task<bool> InsertAgentTicketMappingAsync(Guid agentId, Guid ticketId, Guid createdBy);
        Task<IEnumerable<TicketsDTO>> GetTicketsByAgentAsync(Guid agentId);
    }
}