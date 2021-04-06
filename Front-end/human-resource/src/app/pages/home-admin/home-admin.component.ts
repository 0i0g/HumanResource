import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { MessageService } from 'primeng/api';
import { HumanResourceSystem, ManagerAccount } from './management-model';
import { ManagementService } from './management.service';

@Component({
  selector: 'app-home-admin',
  templateUrl: './home-admin.component.html',
  styleUrls: ['./home-admin.component.scss']
})
export class HomeAdminComponent implements OnInit {
  activeState: boolean[] = [true, false, false];
  listSystem: HumanResourceSystem[];
  listAccount: ManagerAccount[];
  account: ManagerAccount;
  system: HumanResourceSystem;
  isSubmitted: boolean;
  constructor(
    private managementService: ManagementService,
    private messageService: MessageService,
    private route: Router) { }

  ngOnInit(): void {
    this.getListSystem();
    this.getListManagerAccount();
  }
  toggle(index: number) {
    this.activeState[index] = !this.activeState[index];
  }
  async getListSystem() {
    const res = await this.managementService.getListSystem().toPromise();
    this.listSystem = res.data;
  }
  async getListManagerAccount() {
    const res = await this.managementService.getListManagerAccount().toPromise();
    this.listAccount = res.data;
  }
  async onClickCreateSystem(name: string, code: string) {
    this.isSubmitted = true;
    const data = {
      name,
      code,
    };
    const res = await this.managementService.createNewSystem(data).toPromise();
    if (res.statusCode === 200) {
      this.isSubmitted = true;
      this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'System Created!', life: 3000 });
      this.getListSystem();
    }
  }
  async onClickCreateAccount(id, name, role: number) {
    const data = {
      email: name,
      systemid: id,
      role,
    }
    const res = await this.managementService.createManagerAccount(data).toPromise();
    if (res.statusCode === 200) {
      this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'Manger Account Created!', life: 3000 });
      this.getListSystem();
    }
  }
  onLogOut() {
    this.route.navigateByUrl('/');
  }

}
