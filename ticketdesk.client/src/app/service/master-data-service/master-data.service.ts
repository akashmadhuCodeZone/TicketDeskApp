import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { MasterDataDTO } from '../../../model/MasterDataDTO';
import { ExtensionService } from '../extensions.service';

@Injectable({
  providedIn: 'root'
})
export class MasterDataService {
  private apiUrl = 'https://localhost:7290/api';

  constructor(private http: HttpClient,private extension:ExtensionService) { }


  async getAllMasterData(): Promise<MasterDataDTO> {
    try {
      const headers = this.extension.createHeaders();
      return await firstValueFrom(this.http.get<MasterDataDTO>(`${this.apiUrl}/masterdata`, { headers }));
    } catch (error) {
      this.extension.handleError(error);
      throw error;
    }
  }


}

export { MasterDataDTO };
