using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.UserProfile;

namespace TicketDesk.Core.Interfaces
{
    public interface IUserPorofileService
    {
        Task<UserProfileDTO> GetUserProfileAsync(Guid profileId);
        Task<UserProfileDTO> GetUserProfileByUserIdAsync(Guid userId);
        Task<bool> UpdateUserProfileAsync(UserProfileDTO profile);
    }
}
