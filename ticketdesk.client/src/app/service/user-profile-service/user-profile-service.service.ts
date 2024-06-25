import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserProfileDTO } from '../../../model/UserProfileDTO';

@Injectable({
  providedIn: 'root'
})
export class UserProfileService {

  private apiUrl = 'https://localhost:7029/api/'; 

  constructor(private http: HttpClient) { }

  getUserProfile(userId: number): Observable<UserProfileDTO> {
    return this.http.get<UserProfileDTO>(`${this.apiUrl}/userProfiles/${userId}`);
  }

  getGenders(): Observable<{ id: number, name: string }[]> {
    return this.http.get<{ id: number, name: string }[]>(`${this.apiUrl}/genders`);
  }

  getCountries(): Observable<{ id: number, name: string }[]> {
    return this.http.get<{ id: number, name: string }[]>(`${this.apiUrl}/countries`);
  }

  updateUserProfile(user: UserProfileDTO): Observable<UserProfileDTO> {
    return this.http.put<UserProfileDTO>(`${this.apiUrl}/userProfiles/${user.userId}`, user);
  }
}
