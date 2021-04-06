import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { WebRequestService } from 'src/app/web-request.service';
import { Task } from './task-model';

@Injectable({
  providedIn: 'root'
})
export class TaskService {
  constructor(private request: WebRequestService) { }
  getLists(): Observable<any> {
    return this.request.get('task/listtask');
  }
  createTask(data): Observable<any> {
    return this.request.post('task', data);
  }
  assignTask(data): Observable<any> {
    return this.request.post('task/assignto', data);
  }
  updateTask(data): Observable<any> {
    return this.request.put('task', data);
  }
  getAvailableUser(): Observable<any> {
    return this.request.get('listemployeeavailabletask');
  }
  getTaskById(id: string): Observable<any> {
    return this.request.get('task?taskid=' + id);
  }
}
