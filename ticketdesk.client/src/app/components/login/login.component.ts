import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../service/login-services/auth.service';
import { LoginDTO } from '../../../model/LoginDTO';
import { JwtHelperService } from '@auth0/angular-jwt';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent  {
  loginForm: FormGroup;
  submitted = false;
  errorMessage: string | null = null;

  constructor(
    private formBuilder: FormBuilder,
    private router: Router,
    private authService: AuthService,
    private jwtHelper: JwtHelperService
  ) {
    this.loginForm = this.formBuilder.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required]
    });
  }

  

  get f() {
    return this.loginForm.controls;
  }

  async onSubmit() {
    this.submitted = true;

    if (this.loginForm.invalid) {
      return;
    }

    const loginDTO: LoginDTO = {
      email: this.loginForm.value.email,
      password: this.loginForm.value.password
    };

    try {
      console.log('Submitting login form:', loginDTO);
      const response = await this.authService.login(loginDTO);
      console.log('Login response:', response);

      if (response && response.token) {
        const decodedToken = this.jwtHelper.decodeToken(response.token);
        const email = decodedToken.email;
        const role = decodedToken.role || decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
        const userId = decodedToken.sub;

        console.log('Decoded JWT Email:', email);
        console.log('Decoded JWT Role:', role);
        console.log('Decoded JWT UserId:', userId);

        localStorage.setItem('token', response.token);
        localStorage.setItem('email', email);
        localStorage.setItem('role', role);
        localStorage.setItem('userId', userId);

        this.router.navigate(['dashboard/user-profile']);
      }
    } catch (error) {
      console.error('Login error:', error);
      this.errorMessage = 'Invalid email or password';
    }
  }
}
