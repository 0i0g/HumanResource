import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AccountComponent } from './pages/account/account.component';
import { HomeAdminComponent } from './pages/home-admin/home-admin.component';
import { HomeComponent } from './pages/home/home.component';
import { LoginComponent } from './pages/login/login.component';
import { RequestComponent } from './pages/request/request.component';
import { TaskComponent } from './pages/task/task.component';

const routes: Routes = [
  {path: '', component: LoginComponent },
  {path: 'home', component: HomeComponent },
  {path: 'account', component: AccountComponent },
  {path: 'task', component: TaskComponent },
  {path: 'request', component: RequestComponent },
  {path: 'home-admin', component: HomeAdminComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
