import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HomeComponent } from './pages/home/home.component';
import { HeaderComponent } from './pages/common/header/header.component';
import { FooterComponent } from './pages/common/footer/footer.component';
import { CheckboxModule } from 'primeng/checkbox';
import { TableModule } from 'primeng/table';
import { AccountComponent } from './pages/account/account.component';
import { DialogModule } from 'primeng/dialog';
import { ToastModule } from 'primeng/toast';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { ConfirmationService } from 'primeng/api';
import { MessageService } from 'primeng/api';
import { InputTextareaModule } from 'primeng/inputtextarea';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { InputTextModule } from 'primeng/inputtext';
import { FormsModule } from '@angular/forms';
import { TieredMenuModule } from 'primeng/tieredmenu';
import { SlideMenuModule } from 'primeng/slidemenu';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { SlidemenuComponent } from './pages/common/slidemenu/slidemenu.component';
import { InputNumberModule } from 'primeng/inputnumber';
import { TaskComponent } from './pages/task/task.component';
import { RequestComponent } from './pages/request/request.component';
import { MegaMenuModule } from 'primeng/megamenu';
import { MenuModule } from 'primeng/menu';
import { CommonModule } from '@angular/common';
import { LoginModule } from './pages/login/login.module';
import { WebReqInterceptor } from './web-req.interceptor';
import { HomeAdminComponent } from './pages/home-admin/home-admin.component';
import { AccordionModule } from 'primeng/accordion';
import { DropdownModule } from 'primeng/dropdown';
import { TooltipModule } from 'primeng/tooltip';
import { TabViewModule } from 'primeng/tabview';
import {InputSwitchModule} from 'primeng/inputswitch';



@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    HeaderComponent,
    FooterComponent,
    AccountComponent,
    SlidemenuComponent,
    TaskComponent,
    RequestComponent,
    HomeAdminComponent,
  ],
  imports: [
    CommonModule,
    BrowserModule,
    AppRoutingModule,
    CheckboxModule,
    TableModule,
    DialogModule,
    ToastModule,
    ConfirmDialogModule,
    InputTextareaModule,
    HttpClientModule,
    InputTextModule,
    FormsModule,
    TieredMenuModule,
    SlideMenuModule,
    BrowserAnimationsModule,
    InputNumberModule,
    MegaMenuModule,
    MenuModule,
    LoginModule,
    AccordionModule,
    DropdownModule,
    TooltipModule,
    TabViewModule,
    InputSwitchModule

  ],
  providers: [MessageService, ConfirmationService,
    [
      {
        provide: HTTP_INTERCEPTORS,
        useClass: WebReqInterceptor,
        multi: true,
      },
    ]],

  bootstrap: [AppComponent]
})
export class AppModule { }
