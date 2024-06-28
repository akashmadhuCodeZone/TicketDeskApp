import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CustomerService } from '../../service/customer-services/customer.service';
import { CustomerDTO } from '../../../model/CustomerDTO';
import { Router } from '@angular/router';

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
    private customerService: CustomerService,
    private router: Router
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
        roleId: [{ value: 4, disabled: true }]  // Assuming 3 is the role ID for customers
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

    // Enable the form controls before extracting the value
    this.customerForm.get('customerId')?.enable();
    this.customerForm.get('user.userId')?.enable();
    this.customerForm.get('user.roleId')?.enable();

    const customerDTO: CustomerDTO = this.customerForm.getRawValue();
    customerDTO.user.userId = this.generateUUID(); // Generate UUID for new user
    customerDTO.customerId = this.generateUUID(); // Generate UUID for new customer

    // Disable the form controls again after extracting the value
    this.customerForm.get('customerId')?.disable();
    this.customerForm.get('user.userId')?.disable();
    this.customerForm.get('user.roleId')?.disable();

    try {
      const response = await this.customerService.registerCustomer(customerDTO);
      console.log('Customer registered successfully:', response);
      this.router.navigate(['dashboard/user-profile']);  // Navigate to user profile after registration
    } catch (error) {
      console.error('Registration error:', error);
      this.errorMessage = 'Failed to register customer';
    }
  }

  generateUUID(): string {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
      const r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
  }
}
