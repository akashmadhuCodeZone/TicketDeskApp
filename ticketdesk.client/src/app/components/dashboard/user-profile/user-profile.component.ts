import { Component, OnInit } from '@angular/core';
import { UserProfileService } from '../../../service/user-profile-service/user-profile-service.service';
import { UserProfileDTO } from '../../../../model/UserProfileDTO';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit {
  user: UserProfileDTO = new UserProfileDTO();
  genders: { id: number, name: string }[] = [];
  countries: { id: number, name: string }[] = [];

  constructor(private userProfileService: UserProfileService) { }

  ngOnInit(): void {
    this.loadUserProfile(1); // Replace with the actual user ID
    this.loadGenders();
    this.loadCountries();
  }

  loadUserProfile(userId: number): void {
    this.userProfileService.getUserProfile(userId).subscribe(user=> {
      this.user = user;
    });
  }

  loadGenders(): void {
    this.userProfileService.getGenders().subscribe(genders => {
      this.genders = genders;
    });
  }

  loadCountries(): void {
    this.userProfileService.getCountries().subscribe(countries => {
      this.countries = countries;
    });
  }

  onSubmit(): void {
    this.userProfileService.updateUserProfile(this.user).subscribe(updatedUser => {
      console.log('User profile saved', updatedUser);
    });
  }
}
