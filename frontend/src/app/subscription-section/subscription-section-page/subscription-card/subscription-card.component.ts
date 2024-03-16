import {Component, Input} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {CardModule} from "primeng/card";
import {SharedModule} from "primeng/api";
import {SubscriptionDto} from "../../domain/subscription-dto";
import {JsonPipe, NgForOf} from "@angular/common";

@Component({
  selector: 'app-subscription-card',
  standalone: true,
  imports: [
    ButtonModule,
    CardModule,
    SharedModule,
    JsonPipe,
    NgForOf
  ],
  templateUrl: './subscription-card.component.html',
  styleUrl: './subscription-card.component.scss'
})
export class SubscriptionCardComponent {

  @Input() subscriptionDTO: SubscriptionDto | null = null;

}
