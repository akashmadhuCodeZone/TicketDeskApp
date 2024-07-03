using System;
using System.Threading.Tasks;
using TicketDesk.Core.Interfaces;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.UserProfile;

namespace TicketDesk.Core.Services.UserProfile
{
    public class UserProfileService : IUserProfileService
    {
        private readonly IUserProfileDataAccess _userProfileDataAccess;

        public UserProfileService(IUserProfileDataAccess userProfileDataAccess) =>
            _userProfileDataAccess = userProfileDataAccess;

        public Task<UserProfileDTO> GetUserProfileAsync(Guid profileId) =>
            _userProfileDataAccess.GetUserProfileAsync(profileId);

        public Task<UserProfileDTO> GetUserProfileByUserIdAsync(Guid userId) =>
            _userProfileDataAccess.GetUserProfileByUserIdAsync(userId);

        public Task<bool> UpdateUserProfileAsync(UserProfileDTO profile) =>
            _userProfileDataAccess.UpdateUserProfileAsync(profile);
    }
}
