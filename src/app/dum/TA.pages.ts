// src/app/features/user/pages/tokenize-asset/tokenize-asset.component.ts
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';

interface TokenizeAssetRequest {
  name: string;
  symbol: string;
  totalSupply: number;
}

@Component({
  selector: 'app-tokenize-asset',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './tokenize-asset.component.html',
  styleUrls: ['./tokenize-asset.component.scss']
})
export class TokenizeAssetComponent implements OnInit {
  tokenizeForm!: FormGroup;
  loading = false;
  successMessage = '';
  errorMessage = '';

  constructor(
    private fb: FormBuilder,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.initializeForm();
  }

  initializeForm(): void {
    this.tokenizeForm = this.fb.group({
      name: ['', [Validators.required, Validators.minLength(3), Validators.maxLength(100)]],
      symbol: ['', [Validators.required, Validators.minLength(2), Validators.maxLength(10), Validators.pattern(/^[A-Z0-9]+$/)]],
      totalSupply: ['', [Validators.required, Validators.min(1), Validators.max(1000000000)]]
    });
  }

  get f() {
    return this.tokenizeForm.controls;
  }

  onSymbolInput(event: Event): void {
    const input = event.target as HTMLInputElement;
    input.value = input.value.toUpperCase();
    this.tokenizeForm.patchValue({ symbol: input.value });
  }

  onSubmit(): void {
    if (this.tokenizeForm.invalid) {
      this.markFormGroupTouched(this.tokenizeForm);
      return;
    }

    this.loading = true;
    this.errorMessage = '';
    this.successMessage = '';

    const request: TokenizeAssetRequest = {
      name: this.tokenizeForm.value.name,
      symbol: this.tokenizeForm.value.symbol,
      totalSupply: this.tokenizeForm.value.totalSupply
    };

    // TODO: Replace with actual HTTP call
    // this.http.post('/api/tokenization/create', request).subscribe({
    //   next: (response) => {
    //     this.loading = false;
    //     this.successMessage = 'Asset tokenized successfully!';
    //     this.tokenizeForm.reset();
    //   },
    //   error: (error) => {
    //     this.loading = false;
    //     this.errorMessage = error.error?.message || 'Failed to tokenize asset';
    //   }
    // });

    // Simulated success
    setTimeout(() => {
      this.loading = false;
      this.successMessage = `Asset "${request.name}" (${request.symbol}) tokenized successfully!`;
      this.tokenizeForm.reset();
    }, 1500);
  }

  private markFormGroupTouched(formGroup: FormGroup): void {
    Object.keys(formGroup.controls).forEach(key => {
      const control = formGroup.get(key);
      control?.markAsTouched();
    });
  }

  getErrorMessage(fieldName: string): string {
    const control = this.tokenizeForm.get(fieldName);
    if (!control || !control.touched || !control.errors) {
      return '';
    }

    if (control.errors['required']) {
      return `${this.getFieldLabel(fieldName)} is required`;
    }
    if (control.errors['minlength']) {
      return `Minimum ${control.errors['minlength'].requiredLength} characters required`;
    }
    if (control.errors['maxlength']) {
      return `Maximum ${control.errors['maxlength'].requiredLength} characters allowed`;
    }
    if (control.errors['min']) {
      return `Minimum value is ${control.errors['min'].min}`;
    }
    if (control.errors['max']) {
      return `Maximum value is ${control.errors['max'].max}`;
    }
    if (control.errors['pattern']) {
      return 'Only uppercase letters and numbers allowed';
    }
    return 'Invalid input';
  }

  private getFieldLabel(fieldName: string): string {
    const labels: { [key: string]: string } = {
      name: 'Asset Name',
      symbol: 'Symbol',
      totalSupply: 'Total Supply'
    };
    return labels[fieldName] || fieldName;
  }
}