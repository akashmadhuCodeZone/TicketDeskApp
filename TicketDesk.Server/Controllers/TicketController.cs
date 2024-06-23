using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces.Tickets;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TicketController : ControllerBase
    {
        private readonly ITicketService _ticketService;

        public TicketController(ITicketService ticketService)
        {
            _ticketService = ticketService;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllTickets()
        {
            var tickets = await _ticketService.GetAllTicketsAsync();
            return Ok(tickets);
        }

        [HttpGet("{ticketId}")]
        public async Task<IActionResult> GetTicketById(Guid ticketId)
        {
            var ticket = await _ticketService.GetTicketByIdAsync(ticketId);
            if (ticket == null)
            {
                return NotFound("Ticket not found.");
            }
            return Ok(ticket);
        }

        [HttpPost]
        public async Task<IActionResult> CreateTicket([FromBody] TicketsDTO ticket)
        {
            if (ticket == null)
            {
                return BadRequest("Invalid ticket data.");
            }

            var result = await _ticketService.CreateTicketAsync(ticket);
            if (result)
            {
                return Ok("Ticket created successfully.");
            }
            return BadRequest("Failed to create ticket.");
        }

        [HttpPut("{ticketId}")]
        public async Task<IActionResult> UpdateTicket(Guid ticketId, [FromBody] TicketsDTO ticket)
        {
            if (ticket == null || ticket.TicketId != ticketId)
            {
                return BadRequest("Invalid ticket data.");
            }

            var result = await _ticketService.UpdateTicketAsync(ticket);
            if (result)
            {
                return Ok("Ticket updated successfully.");
            }
            return BadRequest("Failed to update ticket.");
        }

        [HttpDelete("{ticketId}")]
        public async Task<IActionResult> DeleteTicket(Guid ticketId)
        {
            var result = await _ticketService.DeleteTicketAsync(ticketId);
            if (result)
            {
                return Ok("Ticket deleted successfully.");
            }
            return BadRequest("Failed to delete ticket.");
        }
    }
}
