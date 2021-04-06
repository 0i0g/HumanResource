import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { WebRequestService } from 'src/app/web-request.service';

@Injectable({
  providedIn: 'root'
})
export class AccountService {

  constructor(private request: WebRequestService) { }
  getListEmployee(): Observable<any> {
    return this.request.get('user/listemployee');
  }
  createEmployee(email): Observable<any> {
    return this.request.post('user/linemanagercreateemployee', email);
  }
  getListRegisterRequired(): Observable<any> {
    return this.request.get('user/listregisterrequest');
  }
  updateEmployee(data): Observable<any> {
    return this.request.put('user/updateemployee', data);
  }
  acceptRegisterRequest(userid): Observable<any> {
    return this.request.post('user/acceptregisterrequest', userid);
  }
  rejectRegisterRequest(userid): Observable<any> {
    return this.request.post('user/rejectregisterrequest', userid);
  }
}
