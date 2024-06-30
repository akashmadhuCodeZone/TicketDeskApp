using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.UserProfile;

namespace TicketDesk.DAL.Repository
{
    public interface IUserProfileDataAccess
    {
        public Task<UserProfileDTO> GetUserProfileAsync(Guid userId);
        public Task<UserProfileDTO> GetUserProfileByUserIdAsync(Guid userId);
        public Task<bool> UpdateUserProfileAsync(UserProfileDTO profile);
    }
}
