import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { GlobalVariable } from '../common/common-context';
import { LoginService } from '../login/login.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  constructor(private router: Router, private loginService: LoginService) { }
  role: number;
  ngOnInit(): void {
    this.loginService.currentRole.subscribe(role => this.role = role);
  }
  goToAccountPage() {
    this.router.navigateByUrl("/account");
  }
  goToTaskPage() {
    this.router.navigateByUrl("/task");
  }
  goToRequestPage() {
    this.router.navigateByUrl("/request");
  }
}
