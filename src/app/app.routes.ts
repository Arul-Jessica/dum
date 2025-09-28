// File: src/app/app.routes.ts
import { Routes } from '@angular/router';
import { MainLayoutComponent } from './shared/components/main-layout/main-layout.component';
import { LoginComponent } from './features/login/login.component';
import { authGuard } from './core/auth/auth.guard';

export const routes: Routes = [
  // --- Public Routes ---
  // These routes do not use the MainLayoutComponent.
  {
    path: 'login',
    component: LoginComponent,
  },
  // We can add a register route here later
  // { path: 'register', component: RegisterComponent },

  // --- Authenticated Routes ---
  // This is the parent route for all pages that require a user to be logged in.
  // It is protected by the authGuard.
  {
    path: '', // It matches the base path after login
    component: MainLayoutComponent,
    canActivate: [authGuard],
    // All routes inside this 'children' array will be rendered inside the
    // <router-outlet> of the MainLayoutComponent.
    children: [
      {
        path: 'dashboard',
        loadComponent: () =>
          import('./features/dashboard/components/dashboard/dashboard.component').then(
            (c) => c.DashboardComponent
          ),
      },
      {
        path: 'trading',
        // Lazy-load the children routes for the entire trading feature
        loadChildren: () =>
          import('./features/trading/trading.routes').then((r) => r.TRADING_ROUTES),
      },
      // If a logged-in user tries to go to the root path (e.g., http://localhost:4200/),
      // we automatically redirect them to their dashboard.
      {
        path: '',
        redirectTo: 'dashboard',
        pathMatch: 'full',
      },
    ],
  },

  // A final catch-all for any URL that doesn't match.
  // We send them to the login page as a fallback.
  {
    path: '**',
    redirectTo: '/login',
    pathMatch: 'full',
  },
];
