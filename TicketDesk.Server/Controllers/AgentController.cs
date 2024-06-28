using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces.Customer;
using TicketDesk.DTO.Customer;
using TicketDesk.DTO.User;

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
        public async Task<IActionResult> CreateAgentAsync([FromBody] CustomerDTO customerDTO)
        {
            if (customerDTO == null)
            {
                return BadRequest("Invalid customer data.");
            }
            return await _customerService.CreateAgentAsync(customerDTO) ? Ok("Customer created successfully.")
                : BadRequest("Failed to create customer.");
            
        }
    }
}
