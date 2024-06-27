/* eslint-disable @typescript-eslint/no-unused-vars */
import { TestBed } from '@angular/core/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { Router } from '@angular/router';
import { JwtHelperService } from '@auth0/angular-jwt';
import { AuthGuard } from './auth.guard';

describe('AuthGuard', () => {
  let guard: AuthGuard;
  let jwtHelperService: JwtHelperService;
  let router: Router;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [RouterTestingModule],
      providers: [
        AuthGuard,
        JwtHelperService
      ]
    });
    guard = TestBed.inject(AuthGuard);
    jwtHelperService = TestBed.inject(JwtHelperService);
    router = TestBed.inject(Router);
  });

  it('should be created', () => {
    expect(guard).toBeTruthy();
  });

  // Add more tests to verify the behavior of the guard
});
