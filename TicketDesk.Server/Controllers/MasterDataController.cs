using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using TicketDesk.Core.Interfaces.MasterData;
using TicketDesk.DTO.MasterData;

namespace TicketDesk.Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class MasterDataController : ControllerBase
    {
        private readonly IMasterDataService _masterDataService;
        public MasterDataController(IMasterDataService masterDataService) => _masterDataService = masterDataService;
        

        [HttpGet]
        public async Task<IActionResult> Get() => 
            await _masterDataService.GetMasterDataAsync() is MasterDataDTO masterData ? Ok(masterData) 
            : StatusCode(500, "Failed to retrieve master data.");

    }
}
