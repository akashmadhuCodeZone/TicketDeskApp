using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using TicketDesk.Core.Interfaces.Tickets;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.Core.Services.Tickets
{
    public class TicketService : ITicketService
    {
        private readonly ITicketDataAccess _ticketDataAccess;

        public TicketService(ITicketDataAccess ticketDataAccess) =>
            _ticketDataAccess = ticketDataAccess;

        public Task<bool> CreateTicketAsync(TicketsDTO ticket) =>
            _ticketDataAccess.CreateTicketAsync(ticket);

        public Task<bool> DeleteTicketAsync(Guid ticketId) =>
            _ticketDataAccess.DeleteTicketAsync(ticketId);

        public Task<List<TicketsDTO>> GetAllTicketsAsync() =>
            _ticketDataAccess.GetAllTicketsAsync();

        public Task<List<TicketsDTO>> GetTicketsWithAgentAsync() =>
            _ticketDataAccess.GetTicketsWithAgentAsync();

        public Task<List<TicketsDTO>> GetTicketsByUserAsync(Guid userId) =>
            _ticketDataAccess.GetTicketsByUserAsync(userId);

        public Task<TicketsDTO> GetTicketByIdAsync(Guid ticketId) =>
            _ticketDataAccess.GetTicketByIdAsync(ticketId);

        public Task<bool> UpdateTicketAsync(TicketsDTO ticket) =>
            _ticketDataAccess.UpdateTicketAsync(ticket);
    }
}
