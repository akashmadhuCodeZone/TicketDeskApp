using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.Customer;

namespace TicketDesk.DAL.Repository
{
    public interface IRegisterationDataAccess
    {
        public Task<bool> RegisterUserAsync(CustomerDTO customerDTO);
    }
}
