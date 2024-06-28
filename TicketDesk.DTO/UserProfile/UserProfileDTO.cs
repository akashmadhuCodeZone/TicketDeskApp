using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.User;

namespace TicketDesk.DTO.UserProfile
{
    public class UserProfileDTO
    {
        public Guid ProfileId { get; set; }
        public Guid UserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public long PhoneNumber { get; set; }
        public string EmailAddress { get; set; }
        public string? DisplayName { get; set; }
        public int? GenderId { get; set; }
        public int? CountryId { get; set; }
        public DateTime? CreatedOn { get; set; }
        public Guid? CreatedBy { get; set; }

        public DateTime? ModifiedOn { get; set; }

        public Guid? ModifiedBy { get; set; }
    }
}
