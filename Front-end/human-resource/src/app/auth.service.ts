import { HttpClient, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { shareReplay, tap } from 'rxjs/operators';
import { Router } from '@angular/router';
import { LoginService } from './pages/login/login.service';

@Injectable({
    providedIn: 'root',
})
export class AuthService {
    constructor(private http: HttpClient, private loginApi: LoginService, private router: Router) { }
    login(data: any) {
        return this.loginApi.apiLogin(data).pipe(
            shareReplay(),
            tap((res) => {
                if (res.statusCode === 200) {
                    this.setSession(res.data._id, res.data.accessToken, res.data.refreshToken);
                }
            })
        );
    }

    logout() {
        this.removeSession();
        this.router.navigate(['/']);
    }

    getAccessToken() {
        return localStorage.getItem('x-access-token');
    }

    setAccessToken(accessToken: string) {
        localStorage.setItem('x-access-token', accessToken);
    }

    getRefreshToken() {
        return localStorage.getItem('x-refresh-token');
    }

    private setSession(userId: any, accessToken: string, refreshToken: string) {
        localStorage.setItem('user-id', userId);
        localStorage.setItem('x-access-token', accessToken);
        localStorage.setItem('x-refresh-token', refreshToken);
    }

    private removeSession() {
        localStorage.removeItem('user-id');
        localStorage.removeItem('x-access-token');
        localStorage.removeItem('x-refresh-token');
    }

    getUserId() {
        return localStorage.getItem('user-id');
    }

    getNewAccessToken() {
        return this.http
            .get(`${this.loginApi.ROOT_URL}/auth/getaccesstoken`, {
                headers: {
                    'x-refresh-token': this.getRefreshToken(),
                    _id: this.getUserId(),
                },
                observe: 'response',
            })
            .pipe(
                tap((res: HttpResponse<any>) => {
                    this.setAccessToken(res.headers.get('x-access-token'));
                })
            );
    }
}