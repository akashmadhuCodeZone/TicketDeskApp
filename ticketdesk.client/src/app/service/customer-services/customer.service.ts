import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { firstValueFrom } from 'rxjs';
import { CustomerDTO as Customer, CustomerDTO } from '../../../model/CustomerDTO';

@Injectable({
  providedIn: 'root'
})
export class CustomerService {
  private apiUrl = 'https://localhost:7290/api';

  constructor(private http: HttpClient) { }

  async getCustomers(): Promise<Customer[]> {
    try {
      const response = await firstValueFrom(this.http.get<Customer[]>(this.apiUrl));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async getCustomerById(id: number): Promise<Customer> {
    try {
      const response = await firstValueFrom(this.http.get<Customer>(`${this.apiUrl}/${id}`));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async createCustomer(customer: Customer): Promise<Customer> {
    try {
      const response = await firstValueFrom(this.http.post<Customer>(this.apiUrl, customer));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async updateCustomer(customer: Customer): Promise<void> {
    try {
      const response = await firstValueFrom(this.http.put<void>(`${this.apiUrl}/${customer.customerId}`, customer));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async deleteCustomer(id: number): Promise<void> {
    try {
      const response = await firstValueFrom(this.http.delete<void>(`${this.apiUrl}/${id}`));
      console.log('Response from API:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }

  async registerCustomer(customer: CustomerDTO): Promise<void> {
    try {
      const response = await firstValueFrom(this.http.post<void>(this.apiUrl +'/customer/register', customer));
      console.log('Customer registered successfully:', response);
      return response;
    } catch (error) {
      console.error('API call error:', error);
      throw error;
    }
  }
}
