import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../../core/services/auth/auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss'],
})
export class LoginComponent {
  credentials = { username: '', password: '' };
  errorMessage = '';

  constructor(private authService: AuthService, private router: Router) {}

  // In login.component.ts

  onSubmit(): void {
    this.errorMessage = '';
    this.authService.login(this.credentials).subscribe({
      next: (response) => {
        // --- THIS IS THE FIX ---
        console.log('Login successful. Checking role...');

        // After login, we immediately ask the AuthService for the user's role.
        const role = this.authService.getUserRole();
        console.log('User role is:', role);

        // Based on the role, we navigate DIRECTLY to the correct dashboard.
        if (role === 'ROLE_ADMIN') {
          console.log('Navigating to ADMIN dashboard...');
          this.router.navigate(['/admin/dashboard']);
        } else if (role === 'ROLE_USER') {
          console.log('Navigating to USER dashboard...');
          this.router.navigate(['/user/dashboard']);
        } else {
          // This is a fallback in case the token is weird or role is missing
          console.error('No valid role found after login. Redirecting to login page.');
          this.errorMessage = 'Login successful, but role could not be determined.';
          this.router.navigate(['/login']);
        }
      },
      error: (err) => {
        this.errorMessage = 'Login failed. Please check credentials.';
        console.error(err);
      },
    });
  }
}
