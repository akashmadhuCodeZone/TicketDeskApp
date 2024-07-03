/* eslint-disable @typescript-eslint/no-explicit-any */
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { LoginDTO } from '../../../model/LoginDTO';
import { JwtHelperService } from '@auth0/angular-jwt';
import { ExtensionService } from '../extensions.service';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl = 'https://localhost:7290/api';

  constructor(private http: HttpClient, private jwtHelper: JwtHelperService,private extension:ExtensionService) { }

  isAuthenticated(): boolean {
    const token = localStorage.getItem('token');
    return token !== null && !this.jwtHelper.isTokenExpired(token);
  }

  async login(loginDTO: LoginDTO): Promise<any> {
    try {
      const response = await firstValueFrom(this.http.post<any>(`${this.apiUrl}/login/login`, loginDTO));
      console.log('Response from API:', response);
      if (response && response.token) {
        localStorage.setItem('token', response.token);
      }
      return response;
    } catch (error) {
      this.extension.handleError(error);
      return null;
    }
  }

  logout(): void {
    localStorage.removeItem('token');
  }

}
