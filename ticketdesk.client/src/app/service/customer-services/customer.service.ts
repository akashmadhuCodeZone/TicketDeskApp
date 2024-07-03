import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { CustomerDTO as Customer, CustomerDTO } from '../../../model/CustomerDTO';
import { ExtensionService } from '../extensions.service';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {
  private apiUrl = 'https://localhost:7290/api/customer';

  constructor(private http: HttpClient, private extensionService: ExtensionService) { }

  async getCustomers(): Promise<Customer[]> {
    try {
      return await firstValueFrom(this.http.get<Customer[]>(this.apiUrl));
    } catch (error) {
      this.extensionService.handleError(error);
      return [];
    }
  }

  async getCustomerById(id: number): Promise<Customer | null> {
    try {
      return await firstValueFrom(this.http.get<Customer>(`${this.apiUrl}/${id}`));
    } catch (error) {
      this.extensionService.handleError(error);
      return null;
    }
  }

  async updateCustomer(customer: Customer): Promise<void> {
    try {
      await firstValueFrom(this.http.put<{ message: string }>(`${this.apiUrl}/${customer.customerId}`, customer));
    } catch (error) {
      this.extensionService.handleError(error);
    }
  }

  async deleteCustomer(id: number): Promise<void> {
    try {
      await firstValueFrom(this.http.delete<{ message: string }>(`${this.apiUrl}/${id}`));
    } catch (error) {
      this.extensionService.handleError(error);
    }
  }

  async registerCustomer(customer: CustomerDTO): Promise<void> {
    try {
      await firstValueFrom(this.http.post<{ message: string }>(`${this.apiUrl}/register`, customer));
    } catch (error) {
      this.extensionService.handleError(error);
    }
  }
}
