import {Injectable} from "@angular/core";
import {AbstractResourceService} from "./abstract-resource-service";
import {HttpClient} from "@angular/common/http";
import {PatientDto} from "../../patient-section/domain/patient-dto";

@Injectable({
  providedIn: 'root',
})
export class PatientResourceService extends AbstractResourceService<PatientDto> {

  constructor(httpClient: HttpClient) {
    super(
      httpClient,
      "patient"
    );
  }

}
