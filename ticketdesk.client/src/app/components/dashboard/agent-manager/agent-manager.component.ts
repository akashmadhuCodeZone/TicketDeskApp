import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AgentService } from '../../../service/agent-services/agent.service';
import { AgentDTO } from '../../../../model/AgentDTO';

@Component({
  selector: 'app-agent-manager',
  templateUrl: './agent-manager.component.html',
  styleUrls: ['./agent-manager.component.css']
})
export class AgentManagerComponent  {
  agentForm: FormGroup;
  errorMessage: string | null = null;

  constructor(
    private formBuilder: FormBuilder,
    private router: Router,
    private agentService: AgentService
  ) {
    this.agentForm = this.formBuilder.group({
      agentId: [{ value: '', disabled: true }],
      user: this.formBuilder.group({
        userId: [{ value: '', disabled: true }],
        firstName: ['', Validators.required],
        lastName: ['', Validators.required],
        phoneNumber: ['', Validators.required],
        emailAddress: ['', [Validators.required, Validators.email]],
        password: ['', Validators.required],
        roleId: ['', Validators.required]
      })
    });
  }

  //ngOnInit(): void {
  //  // Initialize any necessary data here
  //}

  async onSubmit() {
    if (this.agentForm.invalid) {
      return;
    }

    const agentData: AgentDTO = {
      ...this.agentForm.value,
      user: {
        ...this.agentForm.value.user
      }
    };

    try {
      const response = await this.agentService.createOrUpdateAgent(agentData);
      console.log('Agent created/updated successfully:', response);
      this.router.navigate(['/dashboard']); // Navigate to the dashboard after successful creation/update
    } catch (error) {
      console.error('Error creating/updating agent:', error);
      this.errorMessage = 'Failed to create/update agent';
    }
  }
}
