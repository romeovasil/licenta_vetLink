import {UserRole} from "./user-role";

export class UserDTO {
   id : number | null = null;
   firstName: string | null = null;
   lastName: string | null = null;
   email: string | null = null;
   password: string | null = null;
   role: UserRole | null = null
}
