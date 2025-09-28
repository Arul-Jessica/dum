import { Routes } from '@angular/router';
import { LoginComponent } from './features/auth/login/login.component';
import { RegisterComponent } from './features/auth/register/register.component';
import { authGuard } from './core/guards/auth.guard';
import { loginRedirectGuard } from './core/guards/login-redirect.guard';
import { UserLayoutComponent } from './features/user/layout/user-layout/user-layout.component';

export const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  
  { path: '', canActivate: [loginRedirectGuard], children: [] },

  // --- THIS IS THE UPDATED SECTION ---
  {
    path: 'user',
    component: UserLayoutComponent, // Load the layout component first
    canActivate: [authGuard],       // Protect this whole section
    // Now, lazy-load the routes DEFINED IN user.routes.ts
    loadChildren: () => import('./features/user/user.routes').then(r => r.USER_ROUTES)
  },
  // --- END UPDATE ---

  {
    path: 'admin',
    canActivate: [authGuard],
    loadComponent: () => import('./features/placeholder/placeholder.component').then(c => c.PlaceholderComponent)
  },
  
  { path: '**', redirectTo: '/login' }
];