import {Injectable} from "@angular/core";
import {AbstractResourceService} from "./abstract-resource-service";
import {HttpClient} from "@angular/common/http";
import {DoctorDto} from "../../doctors-section/domain/doctor-dto";

@Injectable({
  providedIn: 'root',
})
export class DoctorResourceService extends AbstractResourceService<DoctorDto> {

  constructor(httpClient: HttpClient) {
    super(
      httpClient,
      "doctor"
    );
  }

}
