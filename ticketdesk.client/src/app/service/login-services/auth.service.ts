/* eslint-disable @typescript-eslint/no-explicit-any */
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { LoginDTO } from '../../../model/LoginDTO';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'https://localhost:7290/api'; // Ensure this matches your backend URL

  constructor(private http: HttpClient) { }

  async login(loginDTO: LoginDTO): Promise<any> {
    try {
      const response = await firstValueFrom(this.http.post<any>(`${this.apiUrl}/login/login`, loginDTO));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  logout() {
    localStorage.removeItem('currentUser');
  }
}
