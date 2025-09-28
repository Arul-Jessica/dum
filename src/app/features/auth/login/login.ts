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

  onSubmit(): void {
    this.errorMessage = '';
    this.authService.login(this.credentials).subscribe({
      next: () => {
        // After login, navigate to the root path.
        // Our new LoginRedirectGuard will handle sending the user to the correct dashboard.
        this.router.navigate(['/']);
      },
      error: (err) => {
        this.errorMessage = 'Login failed. Please check your credentials.';
        console.error(err);
      },
    });
  }
}
