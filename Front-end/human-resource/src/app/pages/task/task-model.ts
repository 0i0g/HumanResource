export interface Task {
    id?: string;
    title?: string;
    description?: string;
    priority?: number;
    assignee?: Assignee;
    status?: StatusTask;
    process?: number;
    createdAt?: Date;
    createdBy?: Creator;
}
export interface Assignee {
    id: string;
    username: string;
    fullname: string;
}
export interface Creator {
    id: string;
    username: string;
    fullname: string;
}
export interface AvailableUser {
    status: string;
    user: {
        fullname: string;
        id: string;
        username: string;
    };
}
export interface StatusTask {
    name: string;
    code: string;
  }
