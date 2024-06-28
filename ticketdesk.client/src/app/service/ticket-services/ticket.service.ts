import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { TicketsDTO } from '../../../model/TicketDTO';

@Injectable({
  providedIn: 'root'
})
export class TicketService {
  private apiUrl = 'https://your-api-url/api/tickets'; // Update this URL to your backend API

  constructor(private http: HttpClient) { }

  async getAllTickets(): Promise<TicketsDTO[]> {
    try {
      return await firstValueFrom(this.http.get<TicketsDTO[]>(this.apiUrl));
    } catch (error) {
      console.error('Error fetching tickets', error);
      throw error;
    }
  }

  async createTicket(ticket: TicketsDTO): Promise<void> {
    try {
      await firstValueFrom(this.http.post<void>(this.apiUrl, ticket));
    } catch (error) {
      console.error('Error creating ticket', error);
      throw error;
    }
  }

  async updateTicket(ticketId: string, ticket: TicketsDTO): Promise<void> {
    try {
      await firstValueFrom(this.http.put<void>(`${this.apiUrl}/${ticketId}`, ticket));
    } catch (error) {
      console.error('Error updating ticket', error);
      throw error;
    }
  }

  async deleteTicket(ticketId: string): Promise<void> {
    try {
      await firstValueFrom(this.http.delete<void>(`${this.apiUrl}/${ticketId}`));
    } catch (error) {
      console.error('Error deleting ticket', error);
      throw error;
    }
  }
}
