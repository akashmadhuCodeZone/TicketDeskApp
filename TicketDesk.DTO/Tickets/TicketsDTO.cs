using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TicketDesk.DTO.Tickets
{
    public class TicketsDTO
    {
        public Guid? TicketId { get; set; }
        public int? TicketTypeId { get; set; }
        public int? DepartmentId { get; set; }
        public string TicketTitle { get; set; }
        public string TicketDescription { get; set; }
        public int StatusId { get; set; }
        public Guid? AgentId { get; set; } 
        public string? AgentName { get; set; } 
        public DateTime? CreatedOn { get; set; }
        public Guid? CreatedBy { get; set; }
        public DateTime? ModifiedOn { get; set; }
        public Guid? ModifiedBy { get; set; }
    }

}
