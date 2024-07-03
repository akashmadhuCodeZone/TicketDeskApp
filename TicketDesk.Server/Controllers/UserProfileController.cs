using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces;
using TicketDesk.DTO.UserProfile;
using System;
using System.Threading.Tasks;

namespace TicketDesk.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class UserProfileController : ControllerBase
    {
        private readonly IUserProfileService _userProfileService;

        public UserProfileController(IUserProfileService userProfileService) =>
            _userProfileService = userProfileService;

        [HttpGet("{userId}")]
        public async Task<IActionResult> GetUserProfile(Guid userId) =>
            await this.ExecuteAsync(() => _userProfileService.GetUserProfileAsync(userId), notFoundMessage: "User profile not found.");

        [HttpGet("byUserId/{userId}")]
        public async Task<IActionResult> GetUserProfileByUserId(Guid userId) =>
            await this.ExecuteAsync(() => _userProfileService.GetUserProfileByUserIdAsync(userId), notFoundMessage: "User profile not found.");

        [HttpPut("{profileId}/{userId}")]
        public async Task<IActionResult> UpdateUserProfile(Guid profileId, Guid userId, [FromBody] UserProfileDTO profile) =>
            this.ValidateDto(profile) ??
            await this.ExecuteAsync(() =>
            {
                profile.ProfileId = profileId;
                profile.UserId = userId;
                return _userProfileService.UpdateUserProfileAsync(profile);
            }, successMessage: "User profile updated successfully.", errorMessage: "Failed to update user profile.");
    }
}