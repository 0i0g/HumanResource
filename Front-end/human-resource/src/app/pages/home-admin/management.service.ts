import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { WebRequestService } from 'src/app/web-request.service';

@Injectable({
  providedIn: 'root'
})
export class ManagementService {

  constructor(private request: WebRequestService) { }
  getListSystem(): Observable<any> {
    return this.request.get('system/list');
  }
  getListManagerAccount(): Observable<any> {
    return this.request.get('user/listmanager');
  }
  createNewSystem(data): Observable<any> {
    return this.request.post('system', data);
  }
  createManagerAccount(data): Observable<any> {
    return this.request.post('user/createmanager', data);
  }
}
