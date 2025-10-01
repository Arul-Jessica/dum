import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-stats-card',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './stats-card.component.html',
  styleUrls: ['./stats-card.component.scss']
})
export class StatsCardComponent {
  @Input() title: string = 'Title';
  @Input() value: string | number = 0;
  @Input() icon: string = 'bi-question-circle'; // Default Bootstrap icon
  @Input() bgColor: string = 'bg-light'; // Default background color
}