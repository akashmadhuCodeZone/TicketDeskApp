export class TicketsDTO {
  ticketId!: string; 
  ticketTypeId!: number;
  departmentId!: number;
  ticketTitle!: string;
  ticketDescription!: string;
  statusId!: number;
  createdOn!: Date | null;
  createdBy!: string; 
  modifiedOn!: Date | null;
  modifiedBy!: string; 
}

