export class MasterDataDTO {
  countries!: CountryDto[];
  genders!: GenderDto[];
  departments!: DepartmentDto[];
  roles!: RoleDto[];
  statuses!: StatusDto[];
  ticketTypes!: TicketTypeDto[];
}

export class CountryDto {
  id!: number;
  displayName!: string;
}

export class GenderDto {
  id!: number;
  displayName!: string;
}

export class DepartmentDto {
  id!: number;
  displayName!: string;
}

export class RoleDto {
  id!: number;
  displayName!: string;
}

export class StatusDto {
  id!: number;
  displayName!: string;
}

export class TicketTypeDto {
  id!: number;
  displayName!: string;
}
