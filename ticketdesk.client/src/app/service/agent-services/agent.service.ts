import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { AgentDTO } from '../../../model/AgentDTO';
import { TicketsDTO } from '../../../model/TicketDTO';

@Injectable({
  providedIn: 'root'
})
export class AgentService {
  private apiUrl = 'https://localhost:7290/api/agent'; // Update this URL to your backend API

  constructor(private http: HttpClient) { }

  async getAllAgents(): Promise<AgentDTO[]> {
    try {
      return await firstValueFrom(this.http.get<AgentDTO[]>(this.apiUrl));
    } catch (error) {
      this.handleError(error as HttpErrorResponse);
      throw error;
    }
  }

  async getAgentsPaginated(page: number, size: number): Promise<{ data: AgentDTO[], totalRecords: number }> {
    try {
      return await firstValueFrom(this.http.get<{ data: AgentDTO[], totalRecords: number }>(`${this.apiUrl}/paginated?page=${page}&size=${size}`));
    } catch (error) {
      this.handleError(error as HttpErrorResponse);
      throw error;
    }
  }

  async createAgent(agent: Partial<AgentDTO>): Promise<void> {
    try {
      await firstValueFrom(this.http.post<void>(`${this.apiUrl}/create`, agent));
    } catch (error) {
      this.handleError(error as HttpErrorResponse);
      throw error;
    }
  }

  async updateAgent(agent: Partial<AgentDTO>): Promise<void> {
    try {
      await firstValueFrom(this.http.put<void>(`${this.apiUrl}/${agent.agentId}`, agent));
    } catch (error) {
      this.handleError(error as HttpErrorResponse);
      throw error;
    }
  }

  async deleteAgent(agentId: string): Promise<void> {
    try {
      await firstValueFrom(this.http.delete<void>(`${this.apiUrl}/${agentId}`));
    } catch (error) {
      this.handleError(error as HttpErrorResponse);
      throw error;
    }
  }

  async getAgentById(agentId: string): Promise<AgentDTO> {
    try {
      return await firstValueFrom(this.http.get<AgentDTO>(`${this.apiUrl}/${agentId}`));
    } catch (error) {
      this.handleError(error as HttpErrorResponse);
      throw error;
    }
  }

  async assignAgentToTicket(agentId: string, ticketId: string,userId:string|null): Promise<void> {
    try {
      const assignAgentDto = { agentId,ticketId, userId };
      console.log("agentId, ticketId", agentId, ticketId)
      await firstValueFrom(this.http.post<void>(`${this.apiUrl}/assign`, assignAgentDto));
    } catch (error) {
      this.handleError(error as HttpErrorResponse);
      throw error;
    }
  }

  async getTicketsByAgent(agentId: string): Promise<TicketsDTO[]> {
    try {
      return await firstValueFrom(this.http.get<TicketsDTO[]>(`${this.apiUrl}/tickets/${agentId}`));
    } catch (error) {
      this.handleError(error as HttpErrorResponse);
      throw error;
    }
  }

  private handleError(error: HttpErrorResponse): void {
    if (error.error instanceof ErrorEvent) {
      // A client-side or network error occurred. Handle it accordingly.
      console.error('An error occurred:', error.error.message);
    } else {
      // The backend returned an unsuccessful response code.
      console.error(`Backend returned code ${error.status}, body was: ${error.error}`);
    }
  }
}
