import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { AvailableUser, Task, StatusTask } from './task-model';
import { TaskService } from './task.service';
interface User {
  name: string;
  id: string;
}


@Component({
  selector: 'app-task',
  templateUrl: './task.component.html',
  styleUrls: ['./task.component.scss']
})
export class TaskComponent implements OnInit {
  availableUsers: AvailableUser[];
  taskDialog: boolean;
  assignDialog: boolean;
  isEdit: boolean;
  selectedTasks!: Task[];
  listUser: User[] = [];
  user: User;
  submitted!: boolean;
  listTask: Task[];
  task: Task;
  listStatusTask: StatusTask[] = [];
  constructor(

    private messageService: MessageService,
    private confirmationService: ConfirmationService,
    private taskService: TaskService) {
    this.listStatusTask = [
      {
        name: 'open',
        code: 'OPEN'
      },
      {
        name: 'reopen',
        code: 'REOPEN'
      },
      {
        name: 'resolved',
        code: 'RESOLVED'
      },
      {
        name: 'closed',
        code: 'CLOSED'
      },
    ];
  }

  ngOnInit() {
    this.getTaskList();
    this.getAvailableUser();
  }

  async getTaskList() {
    const res = await this.taskService.getLists().toPromise();
    this.listTask = res.data;
  }
  openNew() {
    this.task = {};
    this.submitted = false;
    this.isEdit = false;
    this.taskDialog = true;
  }

  editProduct(task: Task) {
    this.task = { ...task };
    this.isEdit = true;
    this.taskDialog = true;
  }

  deleteProduct(task: Task) {
    this.confirmationService.confirm({
      message: 'Are you sure you want to delete ' + task.title + '?',
      header: 'Confirm',
      icon: 'pi pi-exclamation-triangle',
      accept: async () => {
        const value = {
          "id": task.id,
          "isdeleted": true
        }
        const res = await this.taskService.updateTask(value).toPromise();
        if (res.statusCode === 200) {
          this.getTaskList();
          this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'Product Deleted', life: 3000 });
        }
      }
    });
  }
  async getAvailableUser() {
    const res = await this.taskService.getAvailableUser().toPromise();
    res.data.forEach((item) => {
      this.listUser.push({ name: item.user.username, id: item.user.id });
    });
  }
  openAssignDialog(task: Task) {
    this.task = { ...task };
    this.assignDialog = true;
  }
  async assignTask(task: Task, user: User) {
    const data = {
      taskid: task.id,
      userid: user?.id
    };

    const res = await this.taskService.assignTask(data).toPromise();
    if (res.statusCode === 200) {
      this.assignDialog = false;
      this.getTaskList();
      this.messageService.
        add({ severity: 'success', summary: 'Successful', detail: 'Assign Task to' + user.name + ' successful!', life: 3000 });
    }
  }

  hideDialog() {
    this.taskDialog = false;
    this.assignDialog = false;
    this.submitted = false;
  }

  async saveProduct() {
    this.submitted = true;
    const data = {
      title: this.task.title,
      description: this.task.description,
      priority: this.task.priority
    }
    if (this.task?.title?.trim()) {
      if (this.task.id) {
        const dataUpdate = {
          id: this.task.id,
          ...data,
          status: this.task.status.name,
        }
      
        const res = await this.taskService.updateTask(dataUpdate).toPromise();
        if (res.statusCode === 200) {
          this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'Task Updated', life: 3000 });
        }
      }
      else {
        const res = await this.taskService.createTask(data).toPromise();
        if (res.statusCode === 200) {
          this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'Task Created', life: 3000 });
        }
      }
      this.getTaskList();
      this.listTask = [...this.listTask];
      this.taskDialog = false;
      this.task = {};
    }
  }
}
