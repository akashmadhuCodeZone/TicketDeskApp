using Microsoft.AspNetCore.Mvc;
using System.ComponentModel;
using TicketDesk.Core.Interfaces.Agent;
using TicketDesk.DTO;
using TicketDesk.DTO.Customer;

namespace TicketDesk.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AgentController : ControllerBase
    {
        private readonly IAgentService _agentService;

        public AgentController(IAgentService agentService)
        {
            _agentService = agentService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllAgents()
        {
            try
            {
                var agents = await _agentService.GetAllAgentsAsync();
                return Ok(agents);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpGet("{agentId}")]
        public async Task<IActionResult> GetAgentById(Guid agentId)
        {
            try
            {
                var agent = await _agentService.GetAgentByIdAsync(agentId);
                if (agent == null)
                {
                    return NotFound("Agent not found.");
                }
                return Ok(agent);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPost("create")]
        public async Task<IActionResult> CreateAgentAsync([FromBody] AgentDTO agentDTO)
        {
            try
            {
                if (agentDTO == null)
                {
                    return BadRequest("Invalid agent data.");
                }

                var result = await _agentService.CreateAgentAsync(agentDTO);
                if (result)
                {
                    return Ok("Agent created successfully.");
                }
                return BadRequest("Failed to create agent.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPut("{agentId}")]
        public async Task<IActionResult> UpdateAgentAsync(Guid agentId, [FromBody] AgentDTO agentDTO)
        {
            try
            {
                if (agentDTO == null)
                {
                    return BadRequest("Invalid agent data.");
                }

                var existingAgent = await _agentService.GetAgentByIdAsync(agentId);
                if (existingAgent == null)
                {
                    return NotFound("Agent not found.");
                }

                var result = await _agentService.UpdateAgentAsync(agentDTO);
                if (result)
                {
                    return Ok("Agent updated successfully.");
                }
                return BadRequest("Failed to update agent.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpDelete("{agentId}")]
        public async Task<IActionResult> DeleteAgentAsync(Guid agentId)
        {
            try
            {
                var existingAgent = await _agentService.GetAgentByIdAsync(agentId);
                if (existingAgent == null)
                {
                    return NotFound("Agent not found.");
                }

                var result = await _agentService.DeleteAgentAsync(agentId);
                if (result)
                {
                    return Ok("Agent deleted successfully.");
                }
                return BadRequest("Failed to delete agent.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpGet("paginated")]
        public async Task<IActionResult> GetAgentsPaginated(int page, int size)
        {
            try
            {
                var result = await _agentService.GetAgentsPaginatedAsync(page, size);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpPost("assign")]
        public async Task<IActionResult> AssignAgentToTicket(AssignAgentDTO assignAgentDTO)
        {
            try
            {
                var result = await _agentService.InsertAgentTicketMappingAsync(assignAgentDTO.AgentId, assignAgentDTO.TicketId,assignAgentDTO.UserId); // Replace with the actual user ID
                if (result)
                {
                    return Ok();
                }
                return BadRequest("Failed to assign agent to ticket.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpGet("tickets/{agentId}")]
        public async Task<IActionResult> GetTicketsByAgent(Guid agentId)
        {
            try
            {
                var tickets = await _agentService.GetTicketsByAgentAsync(agentId);
                return Ok(tickets);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
    }
}
