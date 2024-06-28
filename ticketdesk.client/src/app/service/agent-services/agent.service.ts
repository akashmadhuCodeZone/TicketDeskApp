import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { AgentDTO } from '../../../model/AgentDTO';

@Injectable({
  providedIn: 'root'
})
export class AgentService {
  private apiUrl = 'https://localhost:7290/api';

  constructor(private http: HttpClient) { }

  async createOrUpdateAgent(agent: AgentDTO): Promise<void> {
    try {
      if (agent.agentId) {
        // Update existing agent
        const response = await firstValueFrom(this.http.put<void>(`${this.apiUrl}/${agent.agentId}`, agent));
        console.log('Agent updated successfully:', response);
        return response;
      } else {
        // Create new agent
        const response = await firstValueFrom(this.http.post<void>(this.apiUrl, agent));
        console.log('Agent created successfully:', response);
        return response;
      }
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async getAgentById(agentId: string): Promise<AgentDTO> {
    try {
      const response = await firstValueFrom(this.http.get<AgentDTO>(`${this.apiUrl}/${agentId}`));
      console.log('Fetched agent by ID:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async deleteAgent(agentId: string): Promise<void> {
    try {
      const response = await firstValueFrom(this.http.delete<void>(`${this.apiUrl}/${agentId}`));
      console.log('Agent deleted successfully:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }
}
