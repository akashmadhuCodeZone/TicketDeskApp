import { HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ExtensionService {

  getRole(): string {
    return localStorage.getItem('role') || '';
  }

  getUserId(): string {
    return localStorage.getItem('userId') || '';
  }

  public generateUUID(): string {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
      const r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
  }

  public handleError(error: unknown): never {
    console.error('Error:', error);
    if (error instanceof HttpErrorResponse) {
      throw new Error(`Backend returned code ${error.status}, body was: ${JSON.stringify(error.error)}`);
    } else if (error instanceof Error) {
      throw new Error(`Client Error: ${error.message}`);
    } else {
      throw new Error('Unexpected error occurred.');
    }
  }

  public createHeaders(): HttpHeaders {
    const token = localStorage.getItem('token');
    if (!token) {
      throw new Error('No token found. Please log in again.');
    }
    return new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    });
  }
}
