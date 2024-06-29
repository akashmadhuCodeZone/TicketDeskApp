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
}
