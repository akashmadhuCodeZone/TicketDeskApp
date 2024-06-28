import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { JwtModule, JwtHelperService } from '@auth0/angular-jwt';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './components/login/login.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { AuthService } from './service/login-services/auth.service';
import { AuthGuard } from '../security/auth.guard';
import { AgentManagerComponent } from './components/dashboard/agent-manager/agent-manager.component';
import { UserProfileComponent } from './components/dashboard/user-profile/user-profile.component';
import { TicketManagerComponent } from './components/dashboard/ticket-manager/ticket-manager.component';
import { CustomerRegistrationComponent } from './components/customer-registration/customer-registration.component';

import { TableModule } from 'primeng/table';
import { DialogModule } from 'primeng/dialog';
import { DropdownModule } from 'primeng/dropdown';
import { ButtonModule } from 'primeng/button';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    DashboardComponent,
    AgentManagerComponent,
    TicketManagerComponent,
    UserProfileComponent,
    CustomerRegistrationComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule,
    AppRoutingModule,
    TableModule,
    DialogModule,
    DropdownModule,
    ButtonModule,
    BrowserAnimationsModule,
    JwtModule.forRoot({
      config: {
        tokenGetter: () => localStorage.getItem('token'),
        allowedDomains: ['localhost:7290'],
        disallowedRoutes: ['localhost:7290/api/auth']
      }
    })
  ],
  providers: [AuthService, AuthGuard, JwtHelperService],
  bootstrap: [AppComponent]
})
export class AppModule { }
