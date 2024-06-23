using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TicketDesk.DTO.UserProfile
{
    public class UserProfileDTO
    {
        [Key]
        public Guid ProfileId { get; set; }

        [Required(ErrorMessage = "User ID is required")]
        public Guid UserId { get; set; }

        [Required(ErrorMessage = "Display name is required")]
        [StringLength(100, ErrorMessage = "Display name must be between 1 and 100 characters", MinimumLength = 1)]
        public string DisplayName { get; set; }

        [Required(ErrorMessage = "Gender ID is required")]
        public int GenderId { get; set; }

        [Required(ErrorMessage = "Country ID is required")]
        public int CountryId { get; set; }

        [Required(ErrorMessage = "Created on date is required")]
        public DateTime CreatedOn { get; set; }

        [Required(ErrorMessage = "Created by is required")]
        public Guid CreatedBy { get; set; }

        public DateTime? ModifiedOn { get; set; }

        public Guid? ModifiedBy { get; set; }
    }
}
