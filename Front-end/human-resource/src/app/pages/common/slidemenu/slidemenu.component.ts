import { Component, OnInit } from '@angular/core';
import { MenuItem } from 'primeng/api';
import { LoginService } from '../../login/login.service';

@Component({
  selector: 'app-slidemenu',
  templateUrl: './slidemenu.component.html',
  styleUrls: ['./slidemenu.component.scss']
})
export class SlidemenuComponent implements OnInit {
  items: MenuItem[];
  role: number;
  constructor(private loginService: LoginService) { }

  ngOnInit(): void {
    this.loginService.currentRole.subscribe(role => this.role = role);
    
    this.items = [
      {
        disabled: this.role === 2,
        label: 'Task',
        icon: 'pi pi-fw pi-file',
        routerLink: '/task'
      },
      {
        disabled: this.role === 1,
        label: 'Account',
        icon: 'pi pi-fw pi-user',
        routerLink: '/account'
      },
      {
        disabled: this.role === 1,
        label: 'Request',
        icon: 'pi pi-fw pi-pencil',
        routerLink: '/request'
      },
      {
        label: 'Back',
        icon: 'pi pi-angle-double-left',
        routerLink: '/home'
      }
    ];
  }

}
