import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { JwtModule } from '@auth0/angular-jwt';

import { AppComponent } from './app.component';
import { AuthGuard } from '../security/auth.guard';
import { LoginComponent } from './components/login/login.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { AgentManagerComponent } from './components/dashboard/agent-manager/agent-manager.component';
import { TicketManagerComponent } from './components/dashboard/ticket-manager/ticket-manager.component';
import { UserProfileComponent } from './components/dashboard/user-profile/user-profile.component';
import { CustomerRegistrationComponent } from './components/customer-registration/customer-registration.component';
import { AppRoutingModule } from './app-routing.module';

export function tokenGetter() {
  return localStorage.getItem('token');
}

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
    JwtModule.forRoot({
      config: {
        tokenGetter: tokenGetter,
        allowedDomains: ["localhost:7290"],
        disallowedRoutes: ["localhost:7290/api/auth"]
      }
    })
  ],
  providers: [AuthGuard],
  bootstrap: [AppComponent]
})
export class AppModule { }
