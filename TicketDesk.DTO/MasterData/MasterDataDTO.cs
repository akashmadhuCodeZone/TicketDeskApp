using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TicketDesk.DTO.MasterData
{
    public class MasterDataDTO
    {
        public List<CountryDto> Countries { get; set; }
        public List<GenderDto> Genders { get; set; }
        public List<DepartmentDto> Departments { get; set; }
        public List<RoleDto> Roles { get; set; }
        public List<StatusDto> Statuses { get; set; }
        public List<TicketTypeDto> TicketTypes { get; set; }


        public class CountryDto
        {
            public int Id { get; set; }
            public string DisplayName { get; set; }
        }

        public class GenderDto
        {
            public int Id { get; set; }
            public string DisplayName { get; set; }
        }

        public class DepartmentDto
        {
            public int Id { get; set; }
            public string DisplayName { get; set; }
        }

        public class RoleDto
        {
            public int Id { get; set; }
            public string DisplayName { get; set; }
        }

        public class StatusDto
        {
            public int Id { get; set; }
            public string DisplayName { get; set; }
        }

        public class TicketTypeDto
        {
            public int Id { get; set; }
            public string DisplayName { get; set; }
        }
    }
}
