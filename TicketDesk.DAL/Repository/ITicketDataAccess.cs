using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.DAL.Repository
{
    public interface ITicketDataAccess
    {
        public Task<List<TicketsDTO>> GetAllTicketsAsync();
        public Task<List<TicketsDTO>> GetTicketsByUserAsync(Guid userId);
        public Task<TicketsDTO> GetTicketByIdAsync(Guid ticketId);
        public Task<List<TicketsDTO>> GetTicketsWithAgentAsync();
        public Task<bool> CreateTicketAsync(TicketsDTO ticket);
        public Task<bool> UpdateTicketAsync(TicketsDTO ticket);
        public Task<bool> DeleteTicketAsync(Guid ticketId);
    }
}
