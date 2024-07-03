using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces.Agent;
using TicketDesk.DTO;
using TicketDesk.DTO.Customer;

namespace TicketDesk.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class AgentController : ControllerBase
    {
        private readonly IAgentService _agentService;

        public AgentController(IAgentService agentService) => _agentService = agentService;

        [HttpGet]
        public async Task<IActionResult> GetAllAgents() =>
            await this.ExecuteAsync(() => _agentService.GetAllAgentsAsync());

        [HttpGet("{agentId}")]
        public async Task<IActionResult> GetAgentById(Guid agentId) =>
            await this.ExecuteAsync(() => _agentService.GetAgentByIdAsync(agentId), notFoundMessage: "Agent not found.");

        [HttpPost("create")]
        public async Task<IActionResult> CreateAgentAsync([FromBody] AgentDTO agentDTO) =>
            agentDTO == null ? BadRequest("Invalid agent data.") :
            await this.ExecuteAsync(() => _agentService.CreateAgentAsync(agentDTO), errorMessage: "Failed to create agent.");

        [HttpPut("{agentId}")]
        public async Task<IActionResult> UpdateAgentAsync(Guid agentId, [FromBody] AgentDTO agentDTO) =>
            agentDTO == null ? BadRequest("Invalid agent data.") :
            await this.ExecuteAsync(async () =>
            {
                var existingAgent = await _agentService.GetAgentByIdAsync(agentId);
                return existingAgent != null && await _agentService.UpdateAgentAsync(agentDTO);
            }, notFoundMessage: "Agent not found.", successMessage: "Agent updated successfully.", errorMessage: "Failed to update agent.");

        [HttpDelete("{agentId}")]
        public async Task<IActionResult> DeleteAgentAsync(Guid agentId) =>
            await this.ExecuteAsync(() => _agentService.DeleteAgentAsync(agentId), notFoundMessage: "Agent not found.");

        [HttpGet("paginated")]
        public async Task<IActionResult> GetAgentsPaginated(int page, int size) =>
            await this.ExecuteAsync(() => _agentService.GetAgentsPaginatedAsync(page, size));

        [HttpPost("assign")]
        public async Task<IActionResult> AssignAgentToTicket([FromBody] AssignAgentDTO assignAgentDTO) =>
            await this.ExecuteAsync(() => _agentService.InsertAgentTicketMappingAsync(assignAgentDTO.AgentId, assignAgentDTO.TicketId, assignAgentDTO.UserId),
                errorMessage: "Failed to assign agent to ticket.");

        [HttpGet("tickets/{agentId}")]
        public async Task<IActionResult> GetTicketsByAgent(Guid agentId) =>
            await this.ExecuteAsync(() => _agentService.GetTicketsByAgentAsync(agentId), notFoundMessage: "Agent not found.");
    }
}
