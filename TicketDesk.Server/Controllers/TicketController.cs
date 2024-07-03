using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces.Tickets;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class TicketController : ControllerBase
    {
        private readonly ITicketService _ticketService;

        public TicketController(ITicketService ticketService) => _ticketService = ticketService;

        [HttpGet]
        public async Task<IActionResult> GetAllTickets() =>
            Ok(await _ticketService.GetAllTicketsAsync());

        [HttpGet("ticketId/{ticketId}")]
        public async Task<IActionResult> GetTicketById(Guid ticketId) =>
            await _ticketService.GetTicketByIdAsync(ticketId) is var ticket && ticket != null
                ? Ok(ticket)
                : NotFound("Ticket not found.");

        [HttpGet("user/{userId}")]
        public async Task<IActionResult> GetTicketByUserAsync(Guid userId) =>
            await _ticketService.GetTicketsByUserAsync(userId) is var ticket && ticket != null
                ? Ok(ticket)
                : NotFound("Ticket not found.");

        [HttpGet("ticketsWithAgent")]
        public async Task<IActionResult> GetTicketsWithAgent() =>
            await this.ExecuteAsync(() => _ticketService.GetTicketsWithAgentAsync());

        [HttpPost("create")]
        public async Task<IActionResult> CreateTicket([FromBody] TicketsDTO ticket) =>
            this.ValidateDto(ticket) ??
            await this.ExecuteAsync(() => _ticketService.CreateTicketAsync(ticket),
                successMessage: "Ticket created successfully.", errorMessage: "Failed to create ticket.");

        [HttpPut("{ticketId}")]
        public async Task<IActionResult> UpdateTicket(Guid ticketId, [FromBody] TicketsDTO ticket) =>
            this.ValidateDto(ticket) ??
            (ticket.TicketId != ticketId ? BadRequest("Invalid ticket data.") :
            await this.ExecuteAsync(() => _ticketService.UpdateTicketAsync(ticket),
                successMessage: "Ticket updated successfully.", errorMessage: "Failed to update ticket."));

        [HttpDelete("delete/{ticketId}")]
        public async Task<IActionResult> DeleteTicket(Guid ticketId) =>
            await this.ExecuteAsync(() => _ticketService.DeleteTicketAsync(ticketId),
                successMessage: "Ticket deleted successfully.", errorMessage: "Failed to delete ticket.");
    }
}