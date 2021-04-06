import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MenuItem } from 'primeng/api';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {
  items!: MenuItem[];
  constructor(private router: Router) { }
  userName: string = "Huynh Trong Tri";
  ngOnInit(): void {
    this.items = [{
      items: [{
        label: 'View Profile',
        icon: 'pi pi-user-edit',
        routerLink: '',
      },
      {
        label: 'Log out',
        icon: 'pi pi-sign-out',
        routerLink: '/',
      }
      ]
    },
    ];
  }
  goToHome() {
    this.router.navigateByUrl("/home");
  }
}
