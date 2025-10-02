import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdminService } from '../../services/admin.service';
import { Party } from '../../models/party.model';
import { StatsCardComponent } from '../../components/stats-card/stats-card.component'; // Import the new card
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-party-management',
  standalone: true,
  imports: [CommonModule, StatsCardComponent], // Add StatsCardComponent
  templateUrl: './party-management.component.html',
  styleUrls: ['./party-management.component.scss']
})
export class PartyManagementComponent implements OnInit {
  
  parties: Party[] = [];
  isLoading = true;

  // --- Stats Properties ---
  totalParties = 0;
  activeParties = 0;
  kycBreakdown = { BASIC: 0, ADVANCED: 0, INSTITUTIONAL: 0 };

  constructor(private adminService: AdminService, private toastr: ToastrService) { }

  ngOnInit(): void {
    this.loadParties();
  }

  loadParties(): void {
    this.isLoading = true;
    this.adminService.getAllParties().subscribe({
      next: (data) => {
        this.parties = data;
        this.calculateStats(); // Calculate stats after data arrives
        this.isLoading = false;
      },
      error: (err) => {
        this.toastr.error("Failed to load party data.", "Error");
        this.isLoading = false;
      }
    });
  }

  calculateStats(): void {
    this.totalParties = this.parties.length;
    this.activeParties = this.parties.filter(p => p.status === 'ACTIVE').length;
    
    // Reset and recount KYC breakdown
    this.kycBreakdown = { BASIC: 0, ADVANCED: 0, INSTITUTIONAL: 0 };
    this.parties.forEach(p => {
      if (p.kycLevel in this.kycBreakdown) {
        this.kycBreakdown[p.kycLevel as keyof typeof this.kycBreakdown]++;
      }
    });
  }

  updateStatus(partyId: number, newStatus: string): void {
    this.adminService.updatePartyStatus(partyId, newStatus).subscribe({
      next: (response) => {
        this.toastr.success(response.message, "Status Updated");
        this.loadParties(); // Refresh the entire list and stats
      },
      error: (err) => this.toastr.error(err.error.message, "Update Failed")
    });
  }
} 