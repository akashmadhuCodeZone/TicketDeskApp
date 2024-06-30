import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { UserProfileDTO } from '../../../model/UserProfileDTO';

@Injectable({
  providedIn: 'root'
})
export class UserProfileService {
  private apiUrl = 'https://localhost:7290/api'; // Replace with your actual API URL

  constructor(private http: HttpClient) { }

  private createHeaders(): HttpHeaders {
    const token = localStorage.getItem('token');

    return new HttpHeaders({
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${token}`
    });
  }

  async getUserProfile(userId: string | null): Promise<UserProfileDTO> {
    try {
      const headers = this.createHeaders()
      
      console.log('Headers:', headers);

      const response = await firstValueFrom(this.http.get<UserProfileDTO>(`${this.apiUrl}/userprofile/${userId}`, { headers }));
      return response;
    } catch (error) {
      if (error instanceof HttpErrorResponse) {
        
        console.error('Error fetching user profile:', error.message);
      }
      throw error;
    }
  }

  async updateUserProfile(profileId: string|null,userId:string|null, userProfile: UserProfileDTO): Promise<void> {
    try {
      const headers = this.createHeaders()

      console.log('Headers:', headers);
      await firstValueFrom(this.http.put<void>(`${this.apiUrl}/userprofile/${profileId}/${userId}`, userProfile, {headers}));
    } catch (error) {
      console.error('Error updating user profile', error);
      throw error;
    }
  }

}


