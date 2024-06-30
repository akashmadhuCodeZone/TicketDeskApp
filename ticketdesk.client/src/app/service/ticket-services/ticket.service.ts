import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TicketsDTO } from '../../../model/TicketDTO';

@Injectable({
  providedIn: 'root'
})
export class TicketService {
  private apiUrl = 'https://localhost:7290/api/ticket'; // Update this URL to your backend API

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

  async getAllTicketsByUser(userId: string | null): Promise<TicketsDTO[]> {
    if (!userId) {
      throw new Error('No user ID provided');
    }
    const headers = this.createHeaders();
    return firstValueFrom(this.http.get<TicketsDTO[]>(`${this.apiUrl}/user/${userId}`, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async createTicket(ticket: Partial<TicketsDTO>): Promise<void> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.post<void>(`${this.apiUrl}/create`, ticket, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async updateTicket(ticket: Partial<TicketsDTO>): Promise<void> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.put<void>(`${this.apiUrl}/${ticket.ticketId}`, ticket, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async deleteTicket(ticketId: string): Promise<void> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.delete<void>(`${this.apiUrl}/delete/${ticketId}`, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async getTicketById(ticketId: string): Promise<TicketsDTO> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.get<TicketsDTO>(`${this.apiUrl}/ticketId/${ticketId}`, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async getAllTickets(): Promise<TicketsDTO[]> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.get<TicketsDTO[]>(this.apiUrl, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  async getAllTicketsWithAgent(): Promise<TicketsDTO[]> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.get<TicketsDTO[]>(`${this.apiUrl}/ticketsWithAgent`, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  private handleError(error: unknown): never {
    console.error('Error in TicketService:', error);
    if (error instanceof HttpErrorResponse) {
      throw new Error(`Backend returned code ${error.status}, body was: ${JSON.stringify(error.error)}`);
    } else if (error instanceof Error) {
      throw new Error(`Client Error: ${error.message}`);
    } else {
      throw new Error('Unexpected error occurred.');
    }
  }
}
