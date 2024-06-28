import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { UserProfileDTO } from '../../../model/UserProfileDTO';

@Injectable({
  providedIn: 'root'
})
export class UserProfileService {
  private apiUrl = 'https://localhost:7290/api'; // Replace with your actual API URL

  constructor(private http: HttpClient) { }

  async getUserProfile(userId: string|null): Promise<UserProfileDTO> {
    try {
      const response = await firstValueFrom(this.http.get<UserProfileDTO>(`${this.apiUrl}/userprofile/${userId}`));
      return response;
    } catch (error) {
      console.error('Error fetching user profile', error);
      throw error;
    }
  }

  async updateUserProfile(profileId: string|null,userId:string|null, userProfile: UserProfileDTO): Promise<void> {
    try {
      await firstValueFrom(this.http.put<void>(`${this.apiUrl}/userprofile/${profileId}/${userId}`, userProfile));
    } catch (error) {
      console.error('Error updating user profile', error);
      throw error;
    }
  }

}


