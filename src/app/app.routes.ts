// File: src/app/app.routes.ts
import { Routes } from '@angular/router';
import { LoginComponent } from './features/auth/login/login.component';
import { RegisterComponent } from './features/auth/register/register.component';
import { authGuard } from './core/guards/auth.guard';

export const routes: Routes = [
  // --- Public Routes ---
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },

  // --- Protected User Route ---
  {
    path: 'user/dashboard', // A clear, specific path
    canActivate: [authGuard], // Protected by our guard
    loadComponent: () => import('./features/user/pages/user-dashboard/user-dashboard.component').then(c => c.UserDashboardComponent)
  },

  // --- Protected Admin Route ---
  {
    path: 'admin/dashboard', // A clear, specific path
    canActivate: [authGuard], // Protected by our guard
    loadComponent: () => import('./features/admin/pages/admin-dashboard/admin-dashboard.component').then(c => c.AdminDashboardComponent)
  },

  // --- Default and Wildcard Routes ---
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: '**', redirectTo: '/login' }
];