import {PatientDto} from "../../patient-section/domain/patient-dto";

export class AppointmentRequestDto {
  id: number | null = null;
  customerId: string | null = null;
  clinicId: string | null = null;
  customerEmail: string | null = null;
  customerPhoneNumber: string | null = null;
  details: string | null = null;
  patientDTO: PatientDto | null = null;
  patientInfo: String | null = null;

}
