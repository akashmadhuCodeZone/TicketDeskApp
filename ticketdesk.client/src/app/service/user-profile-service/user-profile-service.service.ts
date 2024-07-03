import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { UserProfileDTO } from '../../../model/UserProfileDTO';
import { ExtensionService } from '../extensions.service';

@Injectable({
  providedIn: 'root'
})
export class UserProfileService {
  private apiUrl = 'https://localhost:7290/api/userprofile';

  constructor(private http: HttpClient,private extension:ExtensionService) { }

  async getUserProfile(userId: string | null): Promise<UserProfileDTO | null> {
    if (!userId) {
      throw new Error('No user ID provided');
    }
    try {
      const headers = this.extension.createHeaders();
      return await firstValueFrom(this.http.get<UserProfileDTO>(`${this.apiUrl}/${userId}`, { headers }));
    } catch (error) {
      this.extension.handleError(error);
      return null;
    }
  }

  async updateUserProfile(profileId: string | null, userId: string | null, userProfile: UserProfileDTO): Promise<void> {
    if (!profileId || !userId) {
      throw new Error('Profile ID and/or User ID not provided');
    }
    try {
      const headers = this.extension.createHeaders();
      await firstValueFrom(this.http.put<{ message: string }>(`${this.apiUrl}/${profileId}/${userId}`, userProfile, { headers }));
    } catch (error) {
      this.extension.handleError(error);
    }
  }

}
