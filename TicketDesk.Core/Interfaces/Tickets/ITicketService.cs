using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.Core.Interfaces.Tickets
{
    public interface ITicketService
    {
        Task<TicketsDTO> GetTicketByIdAsync(Guid ticketId);
        Task<List<TicketsDTO>> GetAllTicketsAsync();
        Task<bool> CreateTicketAsync(TicketsDTO ticket);
        Task<bool> UpdateTicketAsync(TicketsDTO ticket);
        Task<bool> DeleteTicketAsync(Guid ticketId);
    }
}
