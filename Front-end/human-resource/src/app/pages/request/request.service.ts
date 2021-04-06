import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { WebRequestService } from 'src/app/web-request.service';

@Injectable({
  providedIn: 'root'
})
export class RequestService {
  constructor(private request: WebRequestService) { }
  getListDayOffRequest(): Observable<any> {
    return this.request.get('dayoff/listdayoff');
  }
  getListOTRequest(): Observable<any> {
    return this.request.get('ot/listot');
  }
  updateDayOffRequest(data): Observable<any> {
    return this.request.put('dayoff', data);
  }
  updateOTRequest(data): Observable<any> {
    return this.request.put('ot', data);
  }

}
