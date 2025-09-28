import { Routes } from '@angular/router';
import { LoginComponent } from './features/auth/login/login.component';
import { authGuard } from './core/guards/auth.guard';
import { loginRedirectGuard } from './core/guards/login-redirect.guard';

export const routes: Routes = [
  { path: 'login', component: LoginComponent },
  // The root path will redirect logged-in users based on their role
  { path: '', canActivate: [loginRedirectGuard], children: [] },

  // Future protected routes will go here, protected by authGuard
  {
    path: 'user',
    canActivate: [authGuard],
    loadComponent: () =>
      import('./features/placeholder/placeholder.component').then((c) => c.PlaceholderComponent),
  },
  {
    path: 'admin',
    canActivate: [authGuard], // We will add a specific adminGuard later
    loadComponent: () =>
      import('./features/placeholder/placeholder.component').then((c) => c.PlaceholderComponent),
  },

  { path: '**', redirectTo: '/login' },
];
