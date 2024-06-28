export class UserProfileDTO {
  profileId!: string;
  userId!: string;
  firstName!: string;
  lastName!: string;
  phoneNumber!: number;
  emailAddress!: string;
  displayName?: string;
  genderId?: number;
  countryId?: number;
  createdOn?: Date;
  createdBy?: string;
  modifiedOn?: Date;
  modifiedBy?: string;
}
