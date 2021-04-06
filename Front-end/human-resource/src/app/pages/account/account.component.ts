import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { AccountService } from './account.service';
import { EmployeeAccount } from './account-model';

@Component({
  selector: 'app-account',
  templateUrl: './account.component.html',
  styleUrls: ['./account.component.scss']
})
export class AccountComponent implements OnInit {

  accountDialog!: boolean;
  account: EmployeeAccount;
  listAccount: EmployeeAccount[];

  listAccountRequired: EmployeeAccount[];
  accountRequired: EmployeeAccount;

  submitted: boolean;
  isEdit: boolean;
  constructor(
    private accountService: AccountService,
    private messageService: MessageService,
    private confirmationService: ConfirmationService) { }

  ngOnInit() {
    this.getListRegisterRequired();
    this.getListEmployeeAccount();
  }

  openNew() {
    this.account = {};
    this.submitted = false;
    this.isEdit = false;
    this.accountDialog = true;
  }

  async getListEmployeeAccount() {
    const res = await this.accountService.getListEmployee().toPromise();
    this.listAccount = res.data;
  }
  async getListRegisterRequired() {
    const res = await this.accountService.getListRegisterRequired().toPromise();
    this.listAccountRequired = res.data;
  }

  acceptRequire(account: EmployeeAccount) {
    const data = {
      userid: account.id,
    }
    this.confirmationService.confirm({
      message: 'Are you sure you want to create account with username is ' + account.email + '?',
      header: 'Confirm',
      icon: 'pi pi-exclamation-triangle',
      accept: async () => {
        const res = await this.accountService.acceptRegisterRequest(data).toPromise();
        if (res.statusCode === 200) {
          this.getListRegisterRequired();
          this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'Accepted!', life: 3000 });
        }
      }
    });
  }
  editAccount(account: EmployeeAccount) {
    this.account = { ...account };
    this.isEdit = true;
    this.accountDialog = true;
  }
  rejectRequire(account: EmployeeAccount) {
    const data = {
      userid: account.id,
    }
    this.confirmationService.confirm({
      message: 'Are you sure you want to reject this register required ?',
      header: 'Confirm',
      icon: 'pi pi-exclamation-triangle',
      accept: async () => {
        const res = await this.accountService.rejectRegisterRequest(data).toPromise();
        if (res.statusCode === 200) {

          this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'Rejected!', life: 3000 });
        }
      }
    });
  }

  hideDialog() {
    this.accountDialog = false;
    this.submitted = false;
  }

  async saveAccount() {
    this.submitted = true;
    if (this.account?.username?.trim()) {
      if (this.account.id) {
        const data = {
          userid: this.account.id,
          isDeleted: this.account.isDeleted,
        }
        const res = await this.accountService.updateEmployee(data).toPromise();
        if (res.statusCode === 200) {
          this.getListEmployeeAccount();
          this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'Account is updated', life: 3000 });
        }
      }
      else {
        const res = await this.accountService.createEmployee(this.account.username).toPromise();
        if (res.statusCode === 200) {
          this.getListEmployeeAccount();
          this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'Account is created', life: 3000 });
        }
      }
      this.listAccount = [...this.listAccount];
      this.accountDialog = false;
      this.account = {};
    }
  }
}

