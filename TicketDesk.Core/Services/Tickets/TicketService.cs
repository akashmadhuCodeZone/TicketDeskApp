using TicketDesk.Core.Interfaces.Tickets;
using TicketDesk.DAL.Domain;
using TicketDesk.DTO.Tickets;

namespace TicketDesk.Core.Services.Tickets
{
    public class TicketService : ITicketService
    {
        private readonly TicketDataAccess _ticketDataAccess;
        public TicketService(TicketDataAccess ticketDataAccess)
        {
            _ticketDataAccess = ticketDataAccess;
        }

        public async Task<bool> CreateTicketAsync(TicketsDTO ticket)
        {
            try
            {
                return await _ticketDataAccess.CreateTicketAsync(ticket);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<bool> DeleteTicketAsync(Guid ticketId)
        {
            try
            {
                return await _ticketDataAccess.DeleteTicketAsync(ticketId);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<List<TicketsDTO>> GetAllTicketsAsync()
        {
            try
            {
                return await _ticketDataAccess.GetAllTicketsAsync();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<TicketsDTO> GetTicketByIdAsync(Guid ticketId)
        {
            try
            {
                return await _ticketDataAccess.GetTicketByIdAsync(ticketId);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<bool> UpdateTicketAsync(TicketsDTO ticket)
        {
            try
            {
                return await _ticketDataAccess.UpdateTicketAsync(ticket);
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
