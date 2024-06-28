import { Component, OnInit } from '@angular/core';
import { EmailValidator, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { UserProfileService } from '../../../service/user-profile-service/user-profile-service.service';
import { UserProfileDTO } from '../../../../model/UserProfileDTO';
import { MasterDataService } from '../../../service/master-data-service/master-data.service';
import { CountryDto, GenderDto } from '../../../../model/MasterDataDTO';

@Component({
  selector: 'app-user-profile',
  templateUrl: './user-profile.component.html',
  styleUrls: ['./user-profile.component.css']
})
export class UserProfileComponent implements OnInit {
  userProfileForm!: FormGroup;
  genders: GenderDto[] = [];
  countries: CountryDto[] = [];
  submitted = false;
  errorMessage: string | null = null;

  constructor(
    private formBuilder: FormBuilder,
    private masterDataService: MasterDataService,
    private userProfileService: UserProfileService
  ) { }

  async ngOnInit(): Promise<void> {
    this.userProfileForm = this.formBuilder.group({
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      displayName: ['', Validators.required],
      genderId: [null, Validators.required],
      countryId: [null, Validators.required],
      emailAddress: [{ value: '', disabled: true }, [Validators.required, Validators.email]]
    });

    try {
      const masterData = await this.masterDataService.getAllMasterData();
      this.genders = masterData.genders;
      this.countries = masterData.countries;

      const userId = localStorage.getItem('userId'); // Replace with actual user ID logic
      const userProfile = await this.userProfileService.getUserProfile(userId);
      localStorage.setItem('profileId',userProfile.profileId)
      this.userProfileForm.patchValue(userProfile);
    } catch (error) {
      console.error('Error loading master data or user profile', error);
      this.errorMessage = 'Failed to load data';
    }
  }

  get f() {
    return this.userProfileForm.controls;
  }

  async onSubmit() {
    this.submitted = true;

    if (this.userProfileForm.invalid) {
      return;
    }

    try {
      const userProfile: UserProfileDTO = this.userProfileForm.getRawValue();
      const profileId = localStorage.getItem('profileId');
      const userId = localStorage.getItem('userId');
      console.log('userId', userId)
      console.log('profileId', profileId)
      await this.userProfileService.updateUserProfile(profileId, userId, userProfile);
      console.log('User profile updated successfully');
    } catch (error) {
      console.error('Update error:', error);
      this.errorMessage = 'Failed to update user profile';
    }
  }
}
