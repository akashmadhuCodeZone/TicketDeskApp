export class TicketDTO {
  ticketId!: number;
  ticketTypeId!: number;
  departmentId!: number;
  ticketTittle!: string;
  ticketDescription!: string;
  statusId!: number;
  createdOn!: Date;
  createdBy!: number;
  modifiedOn!: Date;
  modifiedBy!: number;
}
