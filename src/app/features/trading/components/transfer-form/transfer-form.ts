import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { TransferRequest, Asset } from '../../models/trading.model';

@Component({
  selector: 'app-transfer-form',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './transfer-form.component.html',
  styleUrls: ['./transfer-form.component.scss']
})
export class TransferFormComponent implements OnInit {
  // It receives the list of available assets from its parent.
  @Input() assets: Asset[] | null = [];
  // It emits the form data up to its parent when submitted.
  @Output() transferSubmit = new EventEmitter<Omit<TransferRequest, 'fromPartyId'>>();

  transferForm!: FormGroup;
  isSubmitting = false;

  constructor(private fb: FormBuilder) { }

  ngOnInit(): void {
    this.transferForm = this.fb.group({
      toPartyId: [null, [Validators.required, Validators.pattern("^[0-9]*$")]],
      assetId: [null, Validators.required],
      quantity: [null, [Validators.required, Validators.min(0.00000001)]],
    });
  }

  get formControls() { return this.transferForm.controls; }

  onSubmit(): void {
    if (this.transferForm.invalid) {
      this.transferForm.markAllAsTouched();
      return;
    }
    this.isSubmitting = true;
    // We emit the form value, excluding fromPartyId, which the parent will add.
    this.transferSubmit.emit(this.transferForm.value);
    
    // For now, we reset the form immediately.
    this.transferForm.reset();
    this.isSubmitting = false;
  }
}