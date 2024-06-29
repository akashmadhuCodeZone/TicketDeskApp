using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TicketDesk.DTO
{
    public class AssignAgentDTO
    {
        public Guid AgentId { get; set; }
        public Guid TicketId { get; set; }
        public Guid UserId { get; set; }
    }

}
