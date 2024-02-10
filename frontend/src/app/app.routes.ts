import {RouterModule, Routes} from '@angular/router';
import {LoginPageComponent} from "./login-page/login-page.component";
import {RegisterPageComponent} from "./register-page/register-page.component";
import {NgModule} from "@angular/core";
import {HomePageComponent} from "./home-page/home-page.component";
import {AddVetClinicPageComponent} from "./clinic-feature/add-vet-clinic-page/add-vet-clinic-page.component";
import {HomeSectionPageComponent} from "./home-section/home-section-page/home-section-page.component";

export const routes: Routes = [
  {path:"",component:LoginPageComponent},
  {path:"register",component:RegisterPageComponent},
  {path:"home",component:HomePageComponent},
  {path:"add-vet-clinic",component:AddVetClinicPageComponent},
  {path:"home",component:HomeSectionPageComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})

 export class AppRoutingModule {}
