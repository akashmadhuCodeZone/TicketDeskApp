using System.Threading.Tasks;
using TicketDesk.Core.Interfaces.MasterData;
using TicketDesk.DAL.Repository;
using TicketDesk.DTO.MasterData;

namespace TicketDesk.Core.Services.MasterData
{
    public class MasterDataService : IMasterDataService
    {
        private readonly IMasterDataAccess _masterDataAccess;

        public MasterDataService(IMasterDataAccess masterDataAccess) =>
            _masterDataAccess = masterDataAccess;

        public Task<MasterDataDTO> GetMasterDataAsync() =>
            _masterDataAccess.GetAllMasterDataAsync();
    }
}
