import {RouterModule, Routes} from '@angular/router';
import {LoginPageComponent} from "./login-page/login-page.component";
import {RegisterPageComponent} from "./register-page/register-page.component";
import {NgModule} from "@angular/core";
import {AddVetClinicPageComponent} from "./clinic-feature/add-vet-clinic-page/add-vet-clinic-page.component";
import {ShopSectionPageComponent} from "./shop-section/shop-section-page/shop-section-page.component";
import {
  SubscriptionSectionPageComponent
} from "./subscription-section/subscription-section-page/subscription-section-page/subscription-section-page.component";
import {AddShopItemPopupComponent} from "./shop-section/add-shop-item-popup/add-shop-item-popup.component";
import {
  NewSubscriptionPopupComponent
} from "./subscription-section/subscription-section-page/new-subscription-popup/new-subscription-popup.component";
import {HttpClientModule} from "@angular/common/http";
import {AppointmentSectionComponent} from "./appointment-section/appointment-section.component";
import {DoctorsSectionComponent} from "./doctors-section/doctors-section.component";
import {NewDoctorPageComponent} from "./doctors-section/new-doctor-page/new-doctor-page.component";
import {PatientSectionComponent} from "./patient-section/patient-section.component";
import {NewPatientPageComponent} from "./patient-section/new-patient-page/new-patient-page.component";
import {NewAppointmentPageComponent} from "./appointment-section/new-appointment-page/new-appointment-page.component";
import {RecommendationsPageComponent} from "./recommendations/recommendations-page/recommendations-page.component";
import {EditPatientPageComponent} from "./patient-section/edit-patient-page/edit-patient-page.component";
import {EditDoctorPageComponent} from "./doctors-section/edit-doctor-page/edit-doctor-page.component";
import {AuthGuard} from "./auth/auth.guard";
import {EditVetClinicPageComponent} from "./clinic-feature/edit-vet-clinic-page/edit-vet-clinic-page.component";
import {
  AppointmentRequestPageComponent
} from "./appointment-request-section/appointment-request-page/appointment-request-page.component";
export const routes: Routes = [
  {path:"",component:LoginPageComponent},
  {path:"register",component:RegisterPageComponent},
  {path:"add-vet-clinic",component:AddVetClinicPageComponent, canActivate: [AuthGuard]},
  {path:"edit-vet-clinic",component:EditVetClinicPageComponent, canActivate: [AuthGuard]},
  {
    path: "shop",
    canActivate: [AuthGuard],
    children: [
      {
        path: '',
        component: ShopSectionPageComponent
      },
      {path: 'new',
      component: AddShopItemPopupComponent},
    ]
  },
  {
    path: "subscriptions",
    canActivate: [AuthGuard],
    children: [
      {
        path: '',
        component: SubscriptionSectionPageComponent
      },
      {
        path: 'new',
        component: NewSubscriptionPopupComponent,
      }
    ],
  },
  {
    path: "appointments",
    canActivate: [AuthGuard],
    children: [
      {
        path: '',
        component: AppointmentSectionComponent
      },
      {
        path: 'new',
        component: NewAppointmentPageComponent
      },
    ],
  },
  {
    path: "requests",
    canActivate: [AuthGuard],
    component: AppointmentRequestPageComponent
  },
  {
    path: "doctors",
    canActivate: [AuthGuard],
    children: [
      {
        path: '',
        component: DoctorsSectionComponent
      },
      {path: 'new',
        component: NewDoctorPageComponent
      },
      {path: 'edit/:doctorId',
        component: EditDoctorPageComponent}
    ],
  },
  {
    path: "patients",
    canActivate: [AuthGuard],
    children: [
      {
        path: '',
        component: PatientSectionComponent
      },
      {path: 'new',
        component: NewPatientPageComponent
      },
      {path: 'edit/:patientId',
        component: EditPatientPageComponent}
    ],
  },
  {
    path: "recommendations",
    canActivate: [AuthGuard],
    children: [
      {
        path: '',
        component: RecommendationsPageComponent
      }
    ],
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes), HttpClientModule],
  exports: [RouterModule,HttpClientModule],
})

 export class AppRoutingModule {}
