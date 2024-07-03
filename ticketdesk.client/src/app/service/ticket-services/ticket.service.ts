import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { TicketsDTO } from '../../../model/TicketDTO';
import { ExtensionService } from '../extensions.service';

@Injectable({
  providedIn: 'root'
})
export class TicketService {
  private apiUrl = 'https://localhost:7290/api/ticket'; // Update this URL to your backend API

  constructor(private http: HttpClient, private extension: ExtensionService) { }


  async getAllTicketsByUser(userId: string | null): Promise<TicketsDTO[]> {
    if (!userId) {
      throw new Error('No user ID provided');
    }
    try {
      const headers = this.extension.createHeaders();
      return await firstValueFrom(this.http.get<TicketsDTO[]>(`${this.apiUrl}/user/${userId}`, { headers }));
    } catch (error) {
      this.extension.handleError(error);
      return [];
    }
  }

  async createTicket(ticket: Partial<TicketsDTO>): Promise<void> {
    try {
      const headers = this.extension.createHeaders();
      await firstValueFrom(this.http.post<{ message: string }>(`${this.apiUrl}/create`, ticket, { headers }));
    } catch (error) {
      this.extension.handleError(error);
    }
  }

  async updateTicket(ticket: Partial<TicketsDTO>): Promise<void> {
    try {
      const headers = this.extension.createHeaders();
      await firstValueFrom(this.http.put<void>(`${this.apiUrl}/${ticket.ticketId}`, ticket, { headers }));
    } catch (error) {
      this.extension.handleError(error);
    }
  }

  async deleteTicket(ticketId: string): Promise<void> {
    try {
      const headers = this.extension.createHeaders();
      await firstValueFrom(this.http.delete<{ message: string }>(`${this.apiUrl}/delete/${ticketId}`, { headers }));
    } catch (error) {
      this.extension.handleError(error);
    }
  }

  async getTicketById(ticketId: string): Promise<TicketsDTO | null> {
    try {
      const headers = this.extension.createHeaders();
      return await firstValueFrom(this.http.get<TicketsDTO>(`${this.apiUrl}/ticketId/${ticketId}`, { headers }));
    } catch (error) {
      this.extension.handleError(error);
      return null;
    }
  }

  async getAllTickets(): Promise<TicketsDTO[]> {
    try {
      const headers = this.extension.createHeaders();
      return await firstValueFrom(this.http.get<TicketsDTO[]>(this.apiUrl, { headers }));
    } catch (error) {
      this.extension.handleError(error);
      return [];
    }
  }

  async getAllTicketsWithAgent(): Promise<TicketsDTO[]> {
    try {
      const headers = this.extension.createHeaders();
      return await firstValueFrom(this.http.get<TicketsDTO[]>(`${this.apiUrl}/ticketsWithAgent`, { headers }));
    } catch (error) {
      this.extension.handleError(error);
      return [];
    }
  }
}
