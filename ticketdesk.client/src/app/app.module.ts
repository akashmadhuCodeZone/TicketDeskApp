import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { JwtModule } from '@auth0/angular-jwt';

import { AppComponent } from './app.component';
import { LoginComponent } from './components/login/login.component';
import { AuthGuard } from '../security/auth.guard';
import { AuthService } from './service/login-services/auth.service';
import { AppRoutingModule } from './app-routing.module';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { AgentManagerComponent } from './components/dashboard/agent-manager/agent-manager.component';
import { UserProfileService } from './service/user-profile-service/user-profile-service.service';
import { UserProfileComponent } from './components/dashboard/user-profile/user-profile.component';

export function tokenGetter() {
  return localStorage.getItem('token');
}

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    DashboardComponent,
    AgentManagerComponent,
    UserProfileComponent
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
  providers: [AuthGuard, AuthService, UserProfileService],
  bootstrap: [AppComponent]
})
export class AppModule { }
