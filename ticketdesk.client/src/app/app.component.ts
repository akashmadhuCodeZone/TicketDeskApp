import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']  // Corrected styleUrl to styleUrls
})
export class AppComponent {

  constructor(private http: HttpClient) { }
}
