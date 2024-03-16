import {RouterModule, Routes} from '@angular/router';
import {LoginPageComponent} from "./login-page/login-page.component";
import {RegisterPageComponent} from "./register-page/register-page.component";
import {NgModule} from "@angular/core";
import {HomePageComponent} from "./home-page/home-page.component";
import {AddVetClinicPageComponent} from "./clinic-feature/add-vet-clinic-page/add-vet-clinic-page.component";
import {HomeSectionPageComponent} from "./home-section/home-section-page/home-section-page.component";
import {ShopSectionPageComponent} from "./shop-section/shop-section-page/shop-section-page.component";
import {
  SubscriptionSectionPageComponent
} from "./subscription-section/subscription-section-page/subscription-section-page/subscription-section-page.component";
import {AddShopItemPopupComponent} from "./shop-section/add-shop-item-popup/add-shop-item-popup.component";
import {
  NewSubscriptionPopupComponent
} from "./subscription-section/subscription-section-page/new-subscription-popup/new-subscription-popup.component";
import {HttpClientModule} from "@angular/common/http";

export const routes: Routes = [
  {path:"",component:LoginPageComponent},
  {path:"register",component:RegisterPageComponent},
  {path:"add-vet-clinic",component:AddVetClinicPageComponent},
  {path:"home",component:HomeSectionPageComponent},
  {
    path: "shop",
    children: [
      {
        path: '',
        component: ShopSectionPageComponent
      },
      {path: 'new',
      component: AddShopItemPopupComponent}

    ]
  },
  {
    path: "subscriptions",
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

];

@NgModule({
  imports: [RouterModule.forRoot(routes), HttpClientModule],
  exports: [RouterModule,HttpClientModule],
})

 export class AppRoutingModule {}
