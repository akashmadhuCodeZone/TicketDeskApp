import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AgentService } from '../../../service/agent-services/agent.service';
import { TicketService } from '../../../service/ticket-services/ticket.service';
import { AgentDTO } from '../../../../model/AgentDTO';
import { ConfirmationService } from 'primeng/api';
import { TicketsDTO } from '../../../../model/TicketDTO';
import { ExtensionService } from '../../../service/extensions.service';

@Component({
  selector: 'app-ticket-manager',
  templateUrl: './ticket-manager.component.html',
  styleUrls: ['./ticket-manager.component.css'],
  providers: [ConfirmationService]
})
export class TicketManagerComponent implements OnInit {
  ticketForm!: FormGroup;
  assignmentForm!: FormGroup;
  tickets: TicketsDTO[] = [];
  agents: AgentDTO[] = [];
  displayDialog = false;
  displayAgentDialog = false;
  isEditMode = false;
  submitted = false;
  role!: string;
  currentTicketId!: string;

  constructor(
    private formBuilder: FormBuilder,
    private ticketService: TicketService,
    private agentService: AgentService,
    private confirmationService: ConfirmationService,
    private extensionService: ExtensionService // Service to get the user role
  ) { }

  async ngOnInit(): Promise<void> {
    this.role = this.extensionService.getRole(); // Get the user role

    this.ticketForm = this.formBuilder.group({
      ticketId: [null],
      ticketTitle: [{ value: '', disabled: this.role !== 'Customer' }, Validators.required],
      ticketDescription: [{ value: '', disabled: this.role !== 'Customer' }, Validators.required],
      statusId: [{ value: { displayName: 'Open', value: 1 }, disabled: !this.isEditMode }, Validators.required], // Default to 'Open' for new tickets
      agentId: [{ value: null, disabled: this.role !== 'Admin' }] // Field for assigning an agent, only enabled for Admin
    });

    this.assignmentForm = this.formBuilder.group({
      agentId: ['', Validators.required]
    });

    await this.loadTickets();
    await this.loadAgents();
  }

  async loadTickets(): Promise<void> {
    try {
      if (this.role === 'Admin') {
        this.tickets = await this.ticketService.getAllTicketsWithAgent();
      } else if (this.role === 'Agent') {
        const agentId = this.extensionService.getUserId();
        this.tickets = await this.agentService.getTicketsByAgent(agentId);
      } else {
        const userId = this.extensionService.getUserId();
        this.tickets = await this.ticketService.getAllTicketsByUser(userId);
      }
    } catch (error) {
      console.error('Error loading tickets', error);
    }
  }

  async loadAgents(): Promise<void> {
    try {
      this.agents = await this.agentService.getAllAgents();
    } catch (error) {
      console.error('Error loading agents', error);
    }
  }

  showDialog(): void {
    this.displayDialog = true;
    this.isEditMode = false;
    this.ticketForm.reset();
    this.submitted = false;
    this.ticketForm.patchValue({
      statusId: { displayName: 'Open', value: 1 } // Set default status to 'Open'
    });
  }

  get f() {
    return this.ticketForm.controls;
  }

  async onSubmit(): Promise<void> {
    this.submitted = true;
    if (this.ticketForm.invalid) {
      return;
    }

    try {
      const statusIdValue = this.ticketForm.controls['statusId'].value?.value || 1; // Default to 1 if undefined or null

      const ticket: Partial<TicketsDTO> = {
        ticketId: this.ticketForm.value.ticketId,
        ticketTitle: this.ticketForm.controls['ticketTitle'].value,
        ticketDescription: this.ticketForm.controls['ticketDescription'].value,
        statusId: statusIdValue,
        agentId: this.ticketForm.value.agentId,
        createdBy: localStorage.getItem('userId')
      };

      if (this.isEditMode) {
        await this.ticketService.updateTicket(ticket);
      } else {
        console.log(ticket)
        await this.ticketService.createTicket(ticket);
      }

      await this.loadTickets();
      this.displayDialog = false;
      this.ngOnInit();
    } catch (error) {
      console.error('Error saving ticket', error);
    }
  }

  async editTicket(ticketId: string): Promise<void> {
    this.isEditMode = true;
    try {
      const ticket = await this.ticketService.getTicketById(ticketId);
      console.log("ticket", ticket)
      this.ticketForm.patchValue({
        ticketId: ticket?.ticketId,
        ticketTitle: ticket?.ticketTitle,
        ticketDescription: ticket?.ticketDescription,
        statusId: ticket?.statusId,
        agentId: ticket?.agentId
      });
      this.displayDialog = true;
    } catch (error) {
      console.error('Error fetching ticket details', error);
    }
  }

  async deleteTicket(ticketId: string): Promise<void> {
    try {
      await this.ticketService.deleteTicket(ticketId);
      this.ngOnInit();
      await this.loadTickets();
    } catch (error) {
      console.error('Error deleting ticket', error);
    }
  }

  confirmDelete(ticketId: string): void {
    this.confirmationService.confirm({
      message: 'Are you sure you want to delete this ticket?',
      accept: () => {
        this.deleteTicket(ticketId);
      }
    });
  }

  // Helper method to get status name based on status ID
  getStatusName(statusId: number): string {
    switch (statusId) {
      case 1:
        return 'Open';
      case 2:
        return 'In Progress';
      case 3:
        return 'Resolved';
      case 4:
        return 'Closed';
      default:
        return 'Unknown';
    }
  }

  // Helper method to get agent name based on agent ID
  getAgentName(agentId: string): string {
    const agent = this.agents.find(a => a.agentId === agentId);
    return agent ? agent.user.firstName : 'Unknown';
  }

  // Helper method to get statuses based on user role
  getStatusesForRole(): { displayName: string, value: number }[] {
    if (this.role === 'Customer') {
      return [
        { displayName: 'Open', value: 1 },
        { displayName: 'Closed', value: 4 }
      ];
    } else if (this.role === 'Admin') {
      return [
        { displayName: 'Open', value: 1 },
        { displayName: 'In Progress', value: 2 },
        { displayName: 'Resolved', value: 3 },
        { displayName: 'Closed', value: 4 }
      ];
    } else if (this.role === 'Agent') {
      return [
        { displayName: 'In Progress', value: 2 },
        { displayName: 'Resolved', value: 3 }
      ];
    }
    return [];
  }

  // Method to show agent assignment dialog
  assignAgent(ticket: TicketsDTO): void {
    this.currentTicketId = ticket.ticketId!;
    this.assignmentForm.reset();
    this.assignmentForm.patchValue({ agentId: ticket.agentId });
    this.displayAgentDialog = true;
  }

  // Method to handle agent assignment submission
  async onAssign(): Promise<void> {
    if (this.assignmentForm.invalid) {
      return;
    }

    try {
      const agentId = this.assignmentForm.value.agentId;
      console.log(this.currentTicketId)
      console.log("agentId", agentId.agentId)
      const userId = localStorage.getItem('userId');
      await this.agentService.assignAgentToTicket(this.currentTicketId, agentId.agentId, userId);
      await this.loadTickets();
      this.displayAgentDialog = false;
    } catch (error) {
      console.error('Error assigning agent', error);
    }
  }
}
