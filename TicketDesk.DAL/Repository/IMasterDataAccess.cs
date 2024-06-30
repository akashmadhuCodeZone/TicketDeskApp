using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.MasterData;

namespace TicketDesk.DAL.Repository
{
    public interface IMasterDataAccess
    {
        public Task<MasterDataDTO> GetAllMasterDataAsync();
    }
}
