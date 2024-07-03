import { Injectable } from '@angular/core';
import { HttpClient} from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { AgentDTO } from '../../../model/AgentDTO';
import { TicketsDTO } from '../../../model/TicketDTO';
import { ExtensionService } from '../extensions.service';

@Injectable({
  providedIn: 'root'
})
export class AgentService {
  private apiUrl = 'https://localhost:7290/api/agent'; // Update this URL to your backend API

  constructor(private http: HttpClient, private extension: ExtensionService) { }

  

  async getAllAgents(): Promise<AgentDTO[]> {
    try {
      const headers = this.extension.createHeaders();
      return await firstValueFrom(this.http.get<AgentDTO[]>(this.apiUrl, { headers }));
    } catch (error) {
      this.extension.handleError(error);
      return [];
    }
  }

  async createAgent(agent: Partial<AgentDTO>): Promise<void> {
    try {
      const headers = this.extension.createHeaders();
      await firstValueFrom(this.http.post<void>(`${this.apiUrl}/create`, agent, { headers }));
    } catch (error) {
      this.extension.handleError(error);
    }
  }

  async updateAgent(agent: Partial<AgentDTO>): Promise<void> {
    try {
      const headers = this.extension.createHeaders();
      await firstValueFrom(this.http.put<void>(`${this.apiUrl}/${agent.agentId}`, agent, { headers }));
    } catch (error) {
      this.extension.handleError(error);
    }
  }

  async deleteAgent(agentId: string): Promise<void> {
    try {
      const headers = this.extension.createHeaders();
      await firstValueFrom(this.http.delete<void>(`${this.apiUrl}/${agentId}`, { headers }));
    } catch (error) {
      this.extension.handleError(error);
    }
  }

  async getAgentById(agentId: string): Promise<AgentDTO | null> {
    try {
      const headers = this.extension.createHeaders();
      return await firstValueFrom(this.http.get<AgentDTO>(`${this.apiUrl}/${agentId}`, { headers }));
    } catch (error) {
      this.extension.handleError(error);
      return null;
    }
  }

  async getTicketsByAgent(agentId: string): Promise<TicketsDTO[]> {
    try {
      const headers = this.extension.createHeaders();
      return await firstValueFrom(this.http.get<TicketsDTO[]>(`${this.apiUrl}/tickets/${agentId}`, { headers }));
    } catch (error) {
      this.extension.handleError(error);
      return [];
    }
  }

  async assignAgentToTicket(ticketId: string, agentId: string, userId: string | null): Promise<void> {
    try {
      const headers = this.extension.createHeaders();
      await firstValueFrom(this.http.post<void>(`${this.apiUrl}/assign`, { ticketId, agentId, userId }, { headers }));
    } catch (error) {
      this.extension.handleError(error);
    }
  }

  
}
