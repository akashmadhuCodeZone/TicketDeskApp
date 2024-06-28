import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { TicketService } from '../../../service/ticket-services/ticket.service';
import { MasterDataService } from '../../../service/master-data-service/master-data.service';
import { TicketsDTO } from '../../../../model/TicketDTO';
import { StatusDto } from '../../../../model/MasterDataDTO';

@Component({
  selector: 'app-ticket-manager',
  templateUrl: './ticket-manager.component.html',
  styleUrls: ['./ticket-manager.component.css']
})
export class TicketManagerComponent implements OnInit {
  ticketForm!: FormGroup;
  tickets: TicketsDTO[] = [];
  statuses: StatusDto[] = [];
  displayDialog!: boolean;
  isEditMode!: boolean;

  constructor(
    private formBuilder: FormBuilder,
    private ticketService: TicketService,
    private masterDataService: MasterDataService
  ) { }

  async ngOnInit(): Promise<void> {
    this.ticketForm = this.formBuilder.group({
      ticketTittle: ['', Validators.required],
      ticketDescription: ['', Validators.required],
      statusId: ['', Validators.required]
    });

    try {
      const masterData = await this.masterDataService.getAllMasterData();
      this.statuses = masterData.statuses;

      this.tickets = await this.ticketService.getAllTickets();
    } catch (error) {
      console.error('Error loading master data or tickets', error);
    }
  }

  showDialog() {
    this.displayDialog = true;
    this.isEditMode = false;
    this.ticketForm.reset();
  }

  get f() {
    return this.ticketForm.controls;
  }

  async onSubmit() {
    if (this.ticketForm.invalid) {
      return;
    }

    try {
      if (this.isEditMode) {
        await this.ticketService.updateTicket(this.ticketForm.value.ticketId, this.ticketForm.value);
      } else {
        await this.ticketService.createTicket(this.ticketForm.value);
      }
      this.tickets = await this.ticketService.getAllTickets();
      this.displayDialog = false;
    } catch (error) {
      console.error('Error saving ticket', error);
    }
  }

  editTicket(ticket: TicketsDTO) {
    this.isEditMode = true;
    this.ticketForm.patchValue(ticket);
    this.displayDialog = true;
  }

  async deleteTicket(ticketId: string) {
    try {
      await this.ticketService.deleteTicket(ticketId);
      this.tickets = await this.ticketService.getAllTickets();
    } catch (error) {
      console.error('Error deleting ticket', error);
    }
  }

  getStatusName(statusId: number): string {
    const status = this.statuses.find(s => s.id === statusId);
    return status ? status.displayName : '';
  }
}
