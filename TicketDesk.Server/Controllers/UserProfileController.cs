using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces;
using TicketDesk.DTO.UserProfile;

namespace TicketDesk.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserProfileController : ControllerBase
    {
        private readonly IUserPorofileService _userProfileService;

        public UserProfileController(IUserPorofileService userPorofileService)
        {
            _userProfileService = userPorofileService;
        }

        [HttpGet("{userId}")]
        public async Task<IActionResult> GetUserProfile(Guid userId)
        {
            try
            {
                var userProfile = await _userProfileService.GetUserProfileAsync(userId);
                if (userProfile == null)
                {
                    return NotFound("User profile not found.");
                }
                return Ok(userProfile);
            }
            catch (Exception)
            {

                throw;
            }
            
        }

        [HttpGet("byUserId/{userId}")]
        public async Task<IActionResult> GetUserProfileByUserId(Guid userId)
        {
            try
            {
                var userProfile = await _userProfileService.GetUserProfileByUserIdAsync(userId);
                if (userProfile == null)
                {
                    return NotFound("User profile not found.");
                }
                return Ok(userProfile);
            }
            catch (Exception)
            {

                throw;
            }
            
        }

        [HttpPut("{profileId}/{userId}")]
        public async Task<IActionResult> UpdateUserProfile(Guid profileId, Guid userId, [FromBody] UserProfileDTO profile)
        {
            try
            {
                if (profile == null)
                {
                    return BadRequest("Invalid user profile data.");
                }

                var result = await _userProfileService.UpdateUserProfileAsync(profile);
                if (result)
                {
                    return Ok("User profile updated successfully.");
                }
                return BadRequest("Failed to update user profile.");
            }
            catch (Exception)
            {

                throw;
            }
            
        }
    }
}
