/* eslint-disable @typescript-eslint/no-explicit-any */
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ConfirmationService } from 'primeng/api';
import { AgentService } from '../../../service/agent-services/agent.service';
import { AgentDTO } from '../../../../model/AgentDTO';

@Component({
  selector: 'app-agent-manager',
  templateUrl: './agent-manager.component.html',
  styleUrls: ['./agent-manager.component.css'],
  providers: [ConfirmationService]
})
export class AgentManagerComponent implements OnInit {
  agentForm!: FormGroup;
  agents: AgentDTO[] = [];
  paginatedAgents: AgentDTO[] = [];
  totalRecords = 0;
  displayDialog = false;
  isEditMode = false;
  submitted = false;
  rows = 5; // Number of rows per page
  first = 0; // First row of the current page

  constructor(
    private formBuilder: FormBuilder,
    private agentService: AgentService,
    private confirmationService: ConfirmationService
  ) { }

  ngOnInit(): void {
    this.agentForm = this.formBuilder.group({
      agentId: [null],
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      phoneNumber: ['', [Validators.required, Validators.maxLength(10), Validators.pattern(/^[0-9]*$/)]],
      emailAddress: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required]
    });

    this.loadAgents();
  }

  async loadAgents(): Promise<void> {
    try {
      const response = await this.agentService.getAllAgents();
      this.agents = response;
      this.totalRecords = this.agents.length;
      this.paginate();
    } catch (error) {
      console.error('Error loading agents', error);
    }
  }

  paginate(): void {
    this.paginatedAgents = this.agents.slice(this.first, this.first + this.rows);
  }

  onPage(event: any): void {
    this.first = event.first;
    this.rows = event.rows;
    this.paginate();
  }

  showDialog(): void {
    this.displayDialog = true;
    this.isEditMode = false;
    this.agentForm.reset();
    this.submitted = false;
  }

  get f() {
    return this.agentForm.controls;
  }

  async onSubmit(): Promise<void> {
    this.submitted = true;
    if (this.agentForm.invalid) {
      return;
    }

    const agent: Partial<AgentDTO> = {
      agentId: this.agentForm.value.agentId,
      user: {
        ...this.agentForm.value,
        roleId: 4 
      }
    };

    try {
      if (this.isEditMode) {
        await this.agentService.updateAgent(agent);
      } else {
        await this.agentService.createAgent(agent);
      }

      await this.loadAgents();
      this.displayDialog = false;
    } catch (error) {
      console.error('Error saving agent', error);
    }
  }

  async editAgent(agentId: string): Promise<void> {
    this.isEditMode = true;
    try {
      const agent = await this.agentService.getAgentById(agentId);
      this.agentForm.patchValue({
        agentId: agent.agentId,
        firstName: agent.user.firstName,
        lastName: agent.user.lastName,
        phoneNumber: agent.user.phoneNumber,
        emailAddress: agent.user.emailAddress,
        password: agent.user.password
      });
      this.displayDialog = true;
    } catch (error) {
      console.error('Error fetching agent details', error);
    }
  }

  async deleteAgent(agentId: string): Promise<void> {
    try {
      await this.agentService.deleteAgent(agentId);
      await this.loadAgents();
    } catch (error) {
      console.error('Error deleting agent', error);
    }
  }

  confirmDelete(agentId: string): void {
    this.confirmationService.confirm({
      message: 'Are you sure you want to delete this agent?',
      accept: () => {
        this.deleteAgent(agentId);
      }
    });
  }

  validateNumber(event: KeyboardEvent): void {
    const pattern = /[0-9]/;
    const inputChar = String.fromCharCode(event.charCode);
    if (!pattern.test(inputChar)) {
      event.preventDefault();
    }
  }
}
