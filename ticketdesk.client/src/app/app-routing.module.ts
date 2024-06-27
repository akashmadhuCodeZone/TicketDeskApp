import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AuthGuard } from '../security/auth.guard';
import { LoginComponent } from './components/login/login.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { AgentManagerComponent } from './components/dashboard/agent-manager/agent-manager.component';
import { TicketManagerComponent } from './components/dashboard/ticket-manager/ticket-manager.component';
import { UserProfileComponent } from './components/dashboard/user-profile/user-profile.component';
import { CustomerRegistrationComponent } from './components/customer-registration/customer-registration.component';

const routes: Routes = [
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },
  { path: 'dashboard', component: DashboardComponent, canActivate: [AuthGuard] },
  { path: 'dashboard/agent-manager', component: AgentManagerComponent, canActivate: [AuthGuard] },
  { path: 'dashboard/ticket-manager', component: TicketManagerComponent, canActivate: [AuthGuard] },
  { path: 'dashboard/user-profile', component: UserProfileComponent, canActivate: [AuthGuard] },
  { path: 'customer-registration', component: CustomerRegistrationComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
