import {PatientDto} from "../../patient-section/domain/patient-dto";
import {ConfirmedScheduleDto} from "./confirmed-schedule-dto";

export class AppointmentDto {
  id: number | null = null;
  patientDTO: PatientDto | null = null
  job: string | null = null;
  color: string | null = null;
  eventLength: number | null = null;
  unscheduled: boolean = false;
  confirmedScheduleDTO: ConfirmedScheduleDto | null = null

}
