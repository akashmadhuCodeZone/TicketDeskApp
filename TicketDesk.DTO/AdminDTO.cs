using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.User;

namespace TicketDesk.DTO
{
    public class AdminDTO
    {
        public Guid? AdminId { get; set; }
        public UserDTO User { get; set; }
        public DateTime? CreatedOn { get; set; }
        public Guid? CreatedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public Guid? ModifiedBy { get; set; }
    }
}
