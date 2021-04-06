import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LoginService {
  private roleSource = new BehaviorSubject<number>(undefined);
  currentRole = this.roleSource.asObservable();
  readonly ROOT_URL;
  constructor(private httpClient: HttpClient) {
    this.ROOT_URL = 'http://hr-env.eba-mvpdrigf.ap-southeast-1.elasticbeanstalk.com/auth/login';

  }
  apiLogin(data: any): Observable<any> {
    return this.httpClient.post(this.ROOT_URL, data);
  }
  changeRole(role: number) {
    this.roleSource.next(role);
  }
}
