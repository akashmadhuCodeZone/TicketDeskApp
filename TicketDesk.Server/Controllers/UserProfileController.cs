using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces;
using TicketDesk.DTO.UserProfile;
using System;
using System.Threading.Tasks;
using TicketDesk.Core.Services.UserProfile;

namespace TicketDesk.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize] 
    public class UserProfileController : ControllerBase
    {
        private readonly IUserProfileService _userProfileService;

        public UserProfileController(IUserProfileService userProfileService)
        {
            _userProfileService = userProfileService;
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
            catch (Exception ex)
            {
                // Log the exception (use a logging framework like Serilog, NLog, etc.)
                return StatusCode(StatusCodes.Status500InternalServerError, "Internal server error.");
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
            catch (Exception ex)
            {
                // Log the exception (use a logging framework like Serilog, NLog, etc.)
                return StatusCode(StatusCodes.Status500InternalServerError, "Internal server error.");
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
                profile.ProfileId = profileId;
                profile.UserId = userId;
                var result = await _userProfileService.UpdateUserProfileAsync(profile);
                if (result)
                {
                    return Ok();
                }
                return BadRequest("Failed to update user profile.");
            }
            catch (Exception ex)
            {
                // Log the exception (use a logging framework like Serilog, NLog, etc.)
                return StatusCode(StatusCodes.Status500InternalServerError, "Internal server error.");
            }
        }
    }
}
