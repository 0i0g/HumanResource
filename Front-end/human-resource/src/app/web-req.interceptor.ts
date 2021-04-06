import { HttpErrorResponse, HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { empty, Observable, Subject, throwError } from 'rxjs';
import { catchError, switchMap, tap } from 'rxjs/operators';
import { AuthService } from './auth.service';

@Injectable({
    providedIn: 'root',
})
export class WebReqInterceptor implements HttpInterceptor {
    constructor(private authService: AuthService) { }

    refreshingAccessToken: boolean;
    accessTokenRefreshed: Subject<any> = new Subject();

    intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
        req = this.addAuthHeader(req);
        return next.handle(req).pipe(
            catchError((error: HttpErrorResponse) => {
                console.log(error);

                if (error.status === 401) {
                    return this.refreshAccessToken().pipe(
                        switchMap(() => {
                            req = this.addAuthHeader(req);
                            return next.handle(req);
                        }),
                        catchError((err: any) => {
                            console.log(err);

                            this.authService.logout();
                            return empty();
                        })
                    );
                }

                return throwError(error);
            })
        );
    }

    refreshAccessToken() {
        console.log('Start Refresh Access Token');
        if (this.refreshingAccessToken) {
            console.log('Refresh Access Token - 1');
            return new Observable((observer) => {
                this.accessTokenRefreshed.subscribe(() => {
                    observer.next();
                    observer.complete();
                });
            });
        } else {
            console.log('Refresh Access Token - 2');
            this.refreshingAccessToken = true;
            return this.authService.getNewAccessToken().pipe(
                tap(() => {
                    this.refreshingAccessToken = false;
                    this.accessTokenRefreshed.next();
                    console.log('Refreshed Access Token!');
                })
            );
        }
    }

    addAuthHeader(request: HttpRequest<any>) {
        const token = this.authService.getAccessToken();
        if (token) {
            return request.clone({
                setHeaders: {
                    'x-access-token': token,
                },
            });
        }
        return request;
    }
}