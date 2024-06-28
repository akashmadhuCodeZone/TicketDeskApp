using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.DTO.MasterData;

namespace TicketDesk.Core.Interfaces.MasterData
{
    public interface IMasterDataService
    {
        public Task<MasterDataDTO> GetMasterDataAsync();
    }
}
