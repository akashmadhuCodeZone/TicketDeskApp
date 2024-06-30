import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AgentDTO } from '../../../model/AgentDTO';
import { TicketsDTO } from '../../../model/TicketDTO';

@Injectable({
  providedIn: 'root'
})
export class AgentService {
  private apiUrl = 'https://localhost:7290/api/agent'; // Update this URL to your backend API

  constructor(private http: HttpClient) { }

  private createHeaders(): HttpHeaders {
    const token = localStorage.getItem('token');
    if (!token) {
      throw new Error('No token found. Please log in again.');
    }
    return new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    });
  }

  async getAllAgents(): Promise<AgentDTO[]> {
    const headers = this.createHeaders();
    return await firstValueFrom(this.http.get<AgentDTO[]>(this.apiUrl, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async createAgent(agent: Partial<AgentDTO>): Promise<void> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.post<void>(this.apiUrl +'/create', agent, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async updateAgent(agent: Partial<AgentDTO>): Promise<void> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.put<void>(`${this.apiUrl}/${agent.agentId}`, agent, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async deleteAgent(agentId: string): Promise<void> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.delete<void>(`${this.apiUrl}/${agentId}`, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async getAgentById(agentId: string): Promise<AgentDTO> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.get<AgentDTO>(`${this.apiUrl}/${agentId}`, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async getTicketsByAgent(agentId: string): Promise<TicketsDTO[]> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.get<TicketsDTO[]>(`${this.apiUrl}/tickets/${agentId}`, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async assignAgentToTicket(ticketId: string, agentId: string, userId: string | null): Promise<void> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.post<void>(`${this.apiUrl}/assign`, { ticketId, agentId, userId }, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  private handleError(error: unknown): never {
    console.error('Error in AgentService:', error);
    if (error instanceof HttpErrorResponse) {
      throw new Error(`Backend returned code ${error.status}, body was: ${JSON.stringify(error.error)}`);
    } else if (error instanceof Error) {
      throw new Error(`Client Error: ${error.message}`);
    } else {
      throw new Error('Unexpected error occurred.');
    }
  }

}
