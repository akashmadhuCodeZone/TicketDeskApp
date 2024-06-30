import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { MasterDataDTO } from '../../../model/MasterDataDTO';

@Injectable({
  providedIn: 'root'
})
export class MasterDataService {
  private apiUrl = 'https://localhost:7290/api'; // Update this URL to your backend API

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

  async getAllMasterData(): Promise<MasterDataDTO> {
    const headers = this.createHeaders();
    return firstValueFrom(this.http.get<MasterDataDTO>(`${this.apiUrl}/masterdata`, { headers }).pipe(
      catchError(async (error) => this.handleError(error))
    ));
  }

  private handleError(error: unknown): never {
    console.error('Error in MasterDataService:', error);
    if (error instanceof HttpErrorResponse) {
      throw new Error(`Backend returned code ${error.status}, body was: ${JSON.stringify(error.error)}`);
    } else if (error instanceof Error) {
      throw new Error(`Client Error: ${error.message}`);
    } else {
      throw new Error('Unexpected error occurred.');
    }
  }
}

export { MasterDataDTO };
