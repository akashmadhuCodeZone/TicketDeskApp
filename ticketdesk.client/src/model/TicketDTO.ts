export class TicketsDTO {
  ticketId!: string; 
  ticketTypeId!: number;
  departmentId!: number;
  ticketTitle!: string;
  ticketDescription!: string;
  statusId!: number;
  agentId?: string|null; 
  agentName?: string|null; 
  createdOn!: Date | null;
  createdBy!: string|null; 
  modifiedOn!: Date | null;
  modifiedBy!: string; 
}

