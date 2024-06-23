using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TicketDesk.Core.Interfaces.Registeration;
using TicketDesk.DAL.Domain;
using TicketDesk.DTO.Registeration;

namespace TicketDesk.Core.Services.Registeration
{
    public class RegisterationService : IRegisterationService
    {

        private readonly RegisterationDataAccess _registerationDataAccess;
        public RegisterationService(RegisterationDataAccess registerationDataAccess)
        {
            _registerationDataAccess = registerationDataAccess;
        }


        public async Task<bool> RegisterUserAsync(RegisterationDTO registeration)
        {
            try
            {
                return await _registerationDataAccess.RegisterUserAsync(registeration);
            }
            catch (Exception)
            {

                throw;
            }
        }

    }
}
