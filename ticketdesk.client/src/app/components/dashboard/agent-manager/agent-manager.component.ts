import { Component, OnInit } from '@angular/core';

interface Agent {
  id: number;
  name: string;
  phone: string;
  email: string;
}

@Component({
  selector: 'app-agent-manager',
  templateUrl: './agent-manager.component.html',
  styleUrls: ['./agent-manager.component.css']
})
export class AgentManagerComponent implements OnInit {
  agent: Agent = { id: 0, name: '', phone: '', email: '' };
  agents: Agent[] = [];
  isEditMode = false;

  //constructor() { }

  ngOnInit(): void {
    this.loadAgents();
  }

  loadAgents(): void {
    // Load agents from a service or API call
    // This is just placeholder data
    this.agents = [
      { id: 1, name: 'Agent Smith', phone: '+1234567890', email: 'smith@example.com' },
      { id: 2, name: 'Agent Johnson', phone: '+0987654321', email: 'johnson@example.com' }
    ];
  }

  onSubmit(): void {
    if (this.isEditMode) {
      // Update the agent
      const index = this.agents.findIndex(a => a.id === this.agent.id);
      if (index !== -1) {
        this.agents[index] = { ...this.agent };
      }
    } else {
      // Create a new agent
      const newAgent = { ...this.agent, id: this.agents.length + 1 };
      this.agents.push(newAgent);
    }
    this.resetForm();
  }

  editAgent(agent: Agent): void {
    this.agent = { ...agent };
    this.isEditMode = true;
  }

  deleteAgent(id: number): void {
    this.agents = this.agents.filter(agent => agent.id !== id);
  }

  resetForm(): void {
    this.agent = { id: 0, name: '', phone: '', email: '' };
    this.isEditMode = false;
  }
}
