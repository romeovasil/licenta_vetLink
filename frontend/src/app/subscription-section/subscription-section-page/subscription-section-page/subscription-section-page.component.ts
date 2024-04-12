import {Component, inject, OnInit} from '@angular/core';
import {ButtonModule} from "primeng/button";
import { Router, RouterModule} from "@angular/router";
import {SubscriptionResourceService} from "../../../utils/resource-service/subscription-resource-service";
import {NgForOf} from "@angular/common";
import {ShopItemCardComponent} from "../../../shop-section/shop-section-page/shop-item-card/shop-item-card.component";
import {SubscriptionCardComponent} from "../subscription-card/subscription-card.component";

@Component({
  selector: 'app-subscription-section-page',
  standalone: true,
  imports: [
    ButtonModule,
    RouterModule,
    NgForOf,
    ShopItemCardComponent,
    SubscriptionCardComponent
  ],
  templateUrl: './subscription-section-page.component.html',
  styleUrl: './subscription-section-page.component.scss'
})
export class SubscriptionSectionPageComponent implements OnInit{
  router = inject(Router);
  subscriptions : any = [];
  private subscriptionResourceService = inject(SubscriptionResourceService);

  ngOnInit() {
    this.subscriptionResourceService.findAll().subscribe(
      res => this.subscriptions = res
    );
  }

  createSubscription() {
    this.router.navigate(['subscriptions', 'new']);
  }
}


