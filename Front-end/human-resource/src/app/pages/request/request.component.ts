import { Component, OnInit } from '@angular/core';
import { MessageService } from 'primeng/api';;
import { EmployeeRequest, StatusRequest } from "./request-model";
import { RequestService } from './request.service';

@Component({
  selector: 'app-request',
  templateUrl: './request.component.html',
  styleUrls: ['./request.component.scss']
})
export class RequestComponent implements OnInit {

  requestDialog: boolean;

  listRequest: EmployeeRequest[] = [];
  request: EmployeeRequest;

  selectedRequests: EmployeeRequest[];
  listStatus: StatusRequest[] = [];
  submitted: boolean;
  typeOfRequest: string[];
  constructor(
    private requestService: RequestService,
    private messageService: MessageService) {
    this.listStatus = [
      {
        name: 'canceled',
        code: 'CANCELED'
      },
      {
        name: 'approve',
        code: 'APPROVE'
      },
      {
        name: 'waiting',
        code: 'WAITING'
      },
    ];
  }

  ngOnInit() {
    this.typeOfRequest = ["OT", "Day-Off"];
    this.getAllRequest();
  }


  async getAllRequest() {
    const res = await this.requestService.getListOTRequest().toPromise();
    const resDayOff = await this.requestService.getListDayOffRequest().toPromise();
    if (res.data !== undefined || resDayOff.data !== undefined) {
      this.listRequest = res.data.concat(resDayOff.data);
    }
  }
  editProduct(request: EmployeeRequest) {
    this.request = { ...request };
    this.requestDialog = true;
  }
  hideDialog() {
    this.requestDialog = false;
    this.submitted = false;
  }
  async saveProduct() {
    this.submitted = true;
    const data = {
      requestid: this.request.requestId,
      status: this.request.status.name
    };
    if (this.request?.status?.name?.trim()) {
      if (this.request.timeOT) {
        const res = await this.requestService.updateOTRequest(data).toPromise();
        if (res.statusCode === 200) {
          this.getAllRequest();
          this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'OT Request is updated', life: 3000 });
        }
      }
      else {
        const res = await this.requestService.updateDayOffRequest(data).toPromise();
        if (res.statusCode === 200) {
          this.getAllRequest();
          this.messageService.add({ severity: 'success', summary: 'Successful', detail: 'Day-off Request is updated', life: 3000 });
        }
      }
      this.listRequest = [...this.listRequest];
      this.requestDialog = false;
      this.request = {};
    }
  }
}
