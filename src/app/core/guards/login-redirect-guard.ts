import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';

export const loginRedirectGuard: CanActivateFn = (route, state) => {
  const authService = inject(AuthService);
  const router = inject(Router);
  const role = authService.getUserRole();

  if (role === 'ROLE_ADMIN') {
    router.navigate(['/admin']);
    return false; // Cancel current navigation
  } else if (role === 'ROLE_USER') {
    router.navigate(['/user']);
    return false; // Cancel current navigation
  }
  // If role is unknown or user isn't logged in, let other guards handle it.
  return true;
};