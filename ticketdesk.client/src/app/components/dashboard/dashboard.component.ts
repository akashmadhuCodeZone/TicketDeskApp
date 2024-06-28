import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {
  username!: string|null;
  role!: string | null;

  constructor(private router: Router) { }

  ngOnInit(): void {
    this.username = localStorage.getItem('email');
    this.role = localStorage.getItem('role');
  }

  logout(): void {
    localStorage.removeItem('email');
    localStorage.removeItem('role');
    localStorage.removeItem('token');
    this.router.navigate(['/login']);
  }
}
