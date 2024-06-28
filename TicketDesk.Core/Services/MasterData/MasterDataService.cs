using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.Core.Interfaces.MasterData;
using TicketDesk.DAL.Domain;
using TicketDesk.DTO.MasterData;

namespace TicketDesk.Core.Services.MasterData
{   
    public class MasterDataService:IMasterDataService
    {
        private readonly MasterDataAccess _masterDataAccess;
        public MasterDataService(MasterDataAccess masterDataAccess)
        {
            _masterDataAccess = masterDataAccess;
        }

        public async Task<MasterDataDTO> GetMasterDataAsync()
        {
            try
            {
                return await _masterDataAccess.GetAllMasterDataAsync();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
