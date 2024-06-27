import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { TicketDTO as Ticket } from '../../../model/TicketDTO'

@Injectable({
  providedIn: 'root'
})
export class TicketService {
  private apiUrl = 'https://localhost:7290/api/ticket';

  constructor(private http: HttpClient) { }

  async getTickets(): Promise<Ticket[]> {
    try {
      const response = await firstValueFrom(this.http.get<Ticket[]>(this.apiUrl));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async getTicketById(id: number): Promise<Ticket> {
    try {
      const response = await firstValueFrom(this.http.get<Ticket>(`${this.apiUrl}/${id}`));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async createTicket(ticket: Ticket): Promise<Ticket> {
    try {
      const response = await firstValueFrom(this.http.post<Ticket>(this.apiUrl, ticket));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async updateTicket(ticket: Ticket): Promise<void> {
    try {
      const response = await firstValueFrom(this.http.put<void>(`${this.apiUrl}/${ticket.ticketId}`, ticket));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async deleteTicket(id: number): Promise<void> {
    try {
      const response = await firstValueFrom(this.http.delete<void>(`${this.apiUrl}/${id}`));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }
}
