import { Creator } from "../task/task-model";
export class EmployeeRequest {
    requestId?: string;
    user?: Creator;
    fromDate?: Date;
    toDate?: Date;
    status?: StatusRequest;
    timeOT?: Date;
}
export interface StatusRequest {
    name: string;
    code: string;
  }
