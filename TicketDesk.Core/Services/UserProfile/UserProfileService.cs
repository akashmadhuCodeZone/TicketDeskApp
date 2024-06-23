using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.Core.Interfaces;
using TicketDesk.DAL.Domain;
using TicketDesk.DTO.UserProfile;

namespace TicketDesk.Core.Services.UserProfile
{
    public class UserProfileService : IUserPorofileService
    {
        private readonly UserProfileDataAccess _userProfileDataAccess;
        public UserProfileService(UserProfileDataAccess userProfileDataAccess)
        {
                _userProfileDataAccess = userProfileDataAccess;
        }
       

        public async Task<UserProfileDTO> GetUserProfileAsync(Guid profileId)
        {
            try
            {
                return await _userProfileDataAccess.GetUserProfileAsync(profileId);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<UserProfileDTO> GetUserProfileByUserIdAsync(Guid userId)
        {
            try
            {
                return await _userProfileDataAccess.GetUserProfileByUserIdAsync(userId);
            }
            catch (Exception)
            {

                throw;
            }
        }

        public async Task<bool> UpdateUserProfileAsync(UserProfileDTO profile)
        {
            try
            {
                return await _userProfileDataAccess.UpdateUserProfileAsync(profile);
            }
            catch (Exception)
            {

                throw;
            }
        }

        

    }
}
