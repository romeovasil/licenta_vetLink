import {Component, inject, OnInit} from '@angular/core';
import {NewSubscriptionFormComponent} from "./new-subscription-form/new-subscription-form.component";
import {SubscriptionDto} from "../../domain/subscription-dto";
import {SubscriptionResourceService} from "../../../utils/resource-service/subscription-resource-service";
import {Router, RouterModule} from "@angular/router";

@Component({
  selector: 'app-new-subscription-popup',
  standalone: true,
  imports: [
    NewSubscriptionFormComponent,
    RouterModule
  ],
  templateUrl: './new-subscription-popup.component.html',
  styleUrl: './new-subscription-popup.component.scss'
})
export class NewSubscriptionPopupComponent implements OnInit{
  private subscriptionResourceService = inject(SubscriptionResourceService);
  router = inject(Router)
  ngOnInit() {

  }

  submitForm($event: SubscriptionDto) {
     this.subscriptionResourceService.save($event).subscribe(
       (res: any) => {
         this.router.navigate(["/subscriptions"]);
       },
     )
  }
}
