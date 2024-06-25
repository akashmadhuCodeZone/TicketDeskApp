import { Component, OnInit } from '@angular/core';
import { TicketDTO } from '../../../../model/TicketDTO';

@Component({
  selector: 'app-ticket-manager',
  templateUrl: './ticket-manager.component.html',
  styleUrls: ['./ticket-manager.component.css']
})
export class TicketManagerComponent implements OnInit {
  ticket: TicketDTO = new TicketDTO();
  tickets: TicketDTO[] = [];
  statuses: { id: number, name: string }[] = [
    { id: 1, name: 'Open' },
    { id: 2, name: 'In Progress' },
    { id: 3, name: 'Closed' }
  ];
  isEditMode = false;

  //constructor() { }

  ngOnInit(): void {
    this.loadTickets();
  }

  loadTickets(): void {
    // Load tickets from a service or API call
    // This is just placeholder data
    this.tickets = [
      {
        ticketId: 1,
        ticketTypeId: 1,
        departmentId: 1,
        ticketTittle: 'Sample Ticket 1',
        ticketDescription: 'This is a sample ticket.',
        statusId: 1,
        createdOn: new Date(),
        createdBy: 1,
        modifiedOn: new Date(),
        modifiedBy: 1
      },
      {
        ticketId: 2,
        ticketTypeId: 2,
        departmentId: 2,
        ticketTittle: 'Sample Ticket 2',
        ticketDescription: 'This is another sample ticket.',
        statusId: 3,
        createdOn: new Date(),
        createdBy: 2,
        modifiedOn: new Date(),
        modifiedBy: 2
      }
    ];
  }

  getStatusName(statusId: number): string {
    const status = this.statuses.find(s => s.id === statusId);
    return status ? status.name : 'Unknown';
  }

  onSubmit(): void {
    if (this.isEditMode) {
      // Update the ticket
      const index = this.tickets.findIndex(t => t.ticketId === this.ticket.ticketId);
      if (index !== -1) {
        this.tickets[index] = { ...this.ticket };
      }
    } else {
      // Create a new ticket
      this.ticket.ticketId = this.tickets.length + 1; // This should be handled by backend normally
      this.tickets.push({ ...this.ticket });
    }
    this.resetForm();
  }

  editTicket(ticket: TicketDTO): void {
    this.ticket = { ...ticket };
    this.isEditMode = true;
  }

  deleteTicket(ticketId: number): void {
    this.tickets = this.tickets.filter(ticket => ticket.ticketId !== ticketId);
  }

  resetForm(): void {
    this.ticket = new TicketDTO();
    this.isEditMode = false;
  }
}
