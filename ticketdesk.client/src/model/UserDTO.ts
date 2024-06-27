export class UserDTO {
  userId!: string;
  firstName!: string;
  lastName!: string;
  phoneNumber!: number;
  emailAddress!: string;
  password!: string;
  roleId!: number;
  createdOn!: Date | null;
  createdBy!: string | null;
  modifiedOn!: Date | null;
  modifiedBy!: string | null;
}
