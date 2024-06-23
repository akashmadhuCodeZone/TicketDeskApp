using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces.Customer;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.Registeration;

namespace TicketDesk.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AgentController : ControllerBase
    {
        private readonly IAgentService _customerService;

        public AgentController(IAgentService customerService)
        {
            _customerService = customerService;
        }

        [HttpPost("create")]
        public async Task<IActionResult> CreateAgentAsync([FromBody] RegisterationDTO registeration)
        {
            if (registeration == null)
            {
                return BadRequest("Invalid customer data.");
            }
            return await _customerService.CreateAgentAsync(registeration) ? Ok("Customer created successfully.")
                : BadRequest("Failed to create customer.");
            
        }
    }
}
