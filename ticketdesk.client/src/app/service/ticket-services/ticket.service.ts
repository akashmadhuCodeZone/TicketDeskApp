import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { TicketsDTO } from '../../../model/TicketDTO';

@Injectable({
  providedIn: 'root'
})
export class TicketService {
  private apiUrl = 'https://localhost:7290/api/ticket'; // Update this URL to your backend API

  constructor(private http: HttpClient) { }

  // Fetch tickets by user ID
  async getAllTicketsByUser(userId: string | null): Promise<TicketsDTO[]> {
    try {
      return await firstValueFrom(this.http.get<TicketsDTO[]>(`${this.apiUrl}/user/${userId}`));
    } catch (error) {
      console.error('Error fetching tickets by user', error);
      throw error;
    }
  }

  // Create a new ticket
  async createTicket(ticket: Partial<TicketsDTO>): Promise<void> {
    try {
      await firstValueFrom(this.http.post<void>(this.apiUrl, ticket));
    } catch (error) {
      console.error('Error creating ticket', error);
      throw error;
    }
  }

  // Update an existing ticket
  async updateTicket(ticket: Partial<TicketsDTO>): Promise<void> {
    try {
      await firstValueFrom(this.http.put<void>(`${this.apiUrl}/${ticket.ticketId}`, ticket));
    } catch (error) {
      console.error('Error updating ticket', error);
      throw error;
    }
  }

  // Delete a ticket by ID
  async deleteTicket(ticketId: string): Promise<void> {
    try {
      await firstValueFrom(this.http.delete<void>(`${this.apiUrl}/delete/${ticketId}`));
    } catch (error) {
      console.error('Error deleting ticket', error);
      throw error;
    }
  }

  // Fetch a single ticket by ID
  async getTicketById(ticketId: string): Promise<TicketsDTO> {
    try {
      return await firstValueFrom(this.http.get<TicketsDTO>(`${this.apiUrl}/ticketId/${ticketId}`));
    } catch (error) {
      console.error('Error fetching ticket by ID', error);
      throw error;
    }
  }

  // Fetch all tickets
  async getAllTickets(): Promise<TicketsDTO[]> {
    try {
      return await firstValueFrom(this.http.get<TicketsDTO[]>(`${this.apiUrl}`));
    } catch (error) {
      this.handleError(error as HttpErrorResponse);
      throw error;
    }
  }

  async getAllTicketsWithAgent(): Promise<TicketsDTO[]> {
    try {
      return await firstValueFrom(this.http.get<TicketsDTO[]>(`${this.apiUrl}/ticketsWithAgent`));
    } catch (error) {
      this.handleError(error as HttpErrorResponse);
      throw error;
    }
  }

  // Error handling method
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
