import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { MasterDataDTO } from '../../../model/MasterDataDTO';

@Injectable({
  providedIn: 'root'
})
export class MasterDataService {
  private apiUrl = 'https://localhost:7290/api'; // Update this URL to your backend API

  constructor(private http: HttpClient) { }

  async getAllMasterData(): Promise<MasterDataDTO> {
    try {
      const response = await firstValueFrom(this.http.get<MasterDataDTO>(`${this.apiUrl}/masterdata`));
      return response;
    } catch (error) {
      console.error('Error fetching master data', error);
      throw error;
    }
  }

}

export { MasterDataDTO };
