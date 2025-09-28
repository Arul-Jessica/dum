import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable, tap } from 'rxjs';
import { environment } from '../../../environments/environment';
import { Router } from '@angular/router';
import { jwtDecode } from 'jwt-decode';

@Injectable({
  providedIn: 'root',
})
export class AuthService {
  private apiUrl = `${environment.apiUrl}/api/auth`; // Your backend's auth endpoint

  // A BehaviorSubject to keep track of the logged-in state in real-time
  private loggedIn = new BehaviorSubject<boolean>(this.hasToken());
  isLoggedIn$ = this.loggedIn.asObservable(); // Expose as a read-only observable

  constructor(private http: HttpClient, private router: Router) {}

  // --- Core Methods ---

  // In AuthService...

  // Add this method
  register(userInfo: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/register`, userInfo);
  }

  // ... (login, logout, and helper methods are the same)

  login(credentials: any): Observable<any> {
    return this.http.post<any>(`${this.apiUrl}/login`, credentials).pipe(
      tap((response) => {
        if (response?.token) {
          localStorage.setItem('authToken', response.token);
          this.loggedIn.next(true); // Notify the app that the user is logged in
        }
      })
    );
  }

  logout(): void {
    localStorage.removeItem('authToken');
    this.loggedIn.next(false); // Notify the app that the user is logged out
    this.router.navigate(['/login']);
  }

  // --- Helper Methods ---

  isLoggedIn(): boolean {
    return this.loggedIn.getValue();
  }

  getToken(): string | null {
    return localStorage.getItem('authToken');
  }

  private getDecodedToken(): any {
    const token = this.getToken();
    return token ? jwtDecode(token) : null;
  }

  getUserRole(): string | null {
    const decodedToken = this.getDecodedToken();
    // This assumes your JWT has a 'roles' claim, which is a common practice.
    // We take the first role in the array.
    return decodedToken?.roles?.[0] || null;
  }
}
