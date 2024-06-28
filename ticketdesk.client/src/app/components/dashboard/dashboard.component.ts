import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {
  username: string | null = null;

  constructor(private router: Router) { }

  ngOnInit(): void {
    this.username = localStorage.getItem('email'); // Assume username is stored in localStorage
  }

  logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('email');
    localStorage.removeItem('role');
    this.router.navigate(['/login']);
  }
}
