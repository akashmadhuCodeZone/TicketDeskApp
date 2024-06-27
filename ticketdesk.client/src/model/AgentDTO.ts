import { UserDTO } from "./UserDTO";

export class AgentDTO {
  agentId!: string | null;
  user!: UserDTO;
  createdOn!: Date | null;
  createdBy!: string | null;
  modifiedOn!: Date | null;
  modifiedBy!: string | null;


}
