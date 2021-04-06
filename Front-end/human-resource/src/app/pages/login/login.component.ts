import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/auth.service';
import { GlobalVariable } from '../common/common-context';
import { LoginService } from './login.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  txtEmail: any;
  txtPassword: any;
  data!: any;
  errorMessage: string = '';
  isError!: boolean;
  commonVar: GlobalVariable;
  constructor(private router: Router, private authService: AuthService, private loginService: LoginService) { }

  ngOnInit(): void {
    this.commonVar = new GlobalVariable();
  }

  async onSummit(username: string, password: string) {
    const data = {
      "username": username,
      "password": password,
    };
    const reqApi = await this.authService.login(data).toPromise();
    if (reqApi.statusCode === 200) {
      this.loginService.changeRole(reqApi.data.role);
      if (reqApi.data.role === 9999) {
        this.router.navigateByUrl('/home-admin');
      } else {
        this.router.navigateByUrl('/home');
      }
    } else {
      this.isError = true;
      this.errorMessage = 'Invalid UserName or Password';
    }
  }
}
