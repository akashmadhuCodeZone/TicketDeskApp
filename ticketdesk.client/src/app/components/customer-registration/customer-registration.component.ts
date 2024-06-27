import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CustomerService } from '../../service/customer-services/customer.service';
import { CustomerDTO } from '../../../model/CustomerDTO';

@Component({
  selector: 'app-customer-registration',
  templateUrl: './customer-registration.component.html',
  styleUrls: ['./customer-registration.component.css']
})
export class CustomerRegistrationComponent implements OnInit {
  customerForm!: FormGroup;
  submitted = false;
  errorMessage: string | null = null;

  constructor(
    private formBuilder: FormBuilder,
    private customerService: CustomerService
  ) { }

  ngOnInit(): void {
    this.customerForm = this.formBuilder.group({
      customerId: [{ value: '', disabled: true }],
      user: this.formBuilder.group({
        userId: [{ value: '', disabled: true }],
        firstName: ['', Validators.required],
        lastName: ['', Validators.required],
        phoneNumber: ['', Validators.required],
        emailAddress: ['', [Validators.required, Validators.email]],
        password: ['', Validators.required],
        roleId: [3, Validators.required],  // Assuming 3 is the role ID for customers
      })
    });
  }

  get f() {
    return this.customerForm.controls;
  }

  async onSubmit() {
    this.submitted = true;

    if (this.customerForm.invalid) {
      return;
    }

    const customerDTO: CustomerDTO = this.customerForm.value;
    customerDTO.user.userId = this.generateUUID(); // Generate UUID for new user
    customerDTO.customerId = this.generateUUID(); // Generate UUID for new customer

    try {
      const response = await this.customerService.registerCustomer(customerDTO);
      console.log('Customer registered successfully:', response);
    } catch (error) {
      console.error('Registration error:', error);
      this.errorMessage = 'Failed to register customer';
    }
  }

  generateUUID(): string {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
      const r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
  }
}
