import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';
import { HeaderComponent } from '../../../shared/components/header/header.component';

@Component({
  selector: 'app-user-layout',
  standalone: true,
  imports: [CommonModule, RouterOutlet, HeaderComponent],
  template: `
    <app-header></app-header>
    <main class="container-fluid mt-4 mb-5">
      <router-outlet></router-outlet>
    </main>
  `,
  styleUrls: ['./user-layout.component.scss']
})
export class UserLayoutComponent {}