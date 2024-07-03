import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { UserProfileService } from '../../../service/user-profile-service/user-profile-service.service';
import { UserProfileDTO } from '../../../../model/UserProfileDTO';
import { MasterDataService } from '../../../service/master-data-service/master-data.service';
import { CountryDto, GenderDto } from '../../../../model/MasterDataDTO';
import { ExtensionService } from '../../../service/extensions.service';

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
    private userProfileService: UserProfileService,
    private extensionService: ExtensionService
  ) { }

  async ngOnInit(): Promise<void> {
    this.initForm();

    try {
      await this.loadMasterData();
      await this.loadUserProfile();
    } catch (error) {
      this.handleError(error, 'Failed to load data');
    }
  }

  private initForm(): void {
    this.userProfileForm = this.formBuilder.group({
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      displayName: ['', Validators.required],
      genderId: [null, Validators.required],
      countryId: [null, Validators.required],
      emailAddress: [{ value: '', disabled: true }, [Validators.required, Validators.email]]
    });
  }

  private async loadMasterData(): Promise<void> {
    const masterData = await this.masterDataService.getAllMasterData();
    this.genders = masterData.genders;
    this.countries = masterData.countries;
  }

  private async loadUserProfile(): Promise<void> {
    const userId = this.extensionService.getUserId();
    const userProfile = await this.userProfileService.getUserProfile(userId);
    if (userProfile) {
      localStorage.setItem('profileId', userProfile.profileId);
      this.userProfileForm.patchValue(userProfile);
    } else {
      this.handleError('User profile not found', 'Failed to load user profile');
    }
  }

  get f() {
    return this.userProfileForm.controls;
  }

  async onSubmit(): Promise<void> {
    this.submitted = true;

    if (this.userProfileForm.invalid) {
      return;
    }

    try {
      const userProfile: UserProfileDTO = this.userProfileForm.getRawValue();
      const profileId = localStorage.getItem('profileId');
      const userId = this.extensionService.getUserId();
      if (profileId && userId) {
        await this.userProfileService.updateUserProfile(profileId, userId, userProfile);
        console.log('User profile updated successfully');
      } else {
        this.handleError('Profile ID or User ID is missing', 'Failed to update user profile');
      }
    } catch (error) {
      this.handleError(error, 'Failed to update user profile');
    }
  }

  private handleError(error: unknown, message: string): void {
    console.error('Error:', error);
    this.errorMessage = message;
  }
}
