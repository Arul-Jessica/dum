import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { Party } from '../models/party.model';
import { GenericResponse } from '../../../models/generic-response.model'; // Use our shared model

@Injectable({
  providedIn: 'root'
})
export class AdminService {
  private adminApiUrl = `${environment.apiUrl}/api/admin`;

  constructor(private http: HttpClient) { }

  // GET /api/admin/parties
  getAllParties(): Observable<Party[]> {
    return this.http.get<Party[]>(`${this.adminApiUrl}/parties`);
  }

  // PUT /api/admin/parties/{partyId}/status
  updatePartyStatus(partyId: number, status: string): Observable<GenericResponse> {
    return this.http.put<GenericResponse>(`${this.adminApiUrl}/parties/${partyId}/status`, { status });
  }
}