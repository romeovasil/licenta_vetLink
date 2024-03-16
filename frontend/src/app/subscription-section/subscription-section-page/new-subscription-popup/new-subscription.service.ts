import {inject, Injectable} from '@angular/core';
import {SubscriptionResourceService} from "../../../utils/resource-service/subscription-resource-service";
import {Observable} from "rxjs";
import {SubscriptionDto} from "../../domain/subscription-dto";

@Injectable({
  providedIn: 'root'
})
export class NewSubscriptionService {
  private subscriptionResourceService = inject(SubscriptionResourceService)
  constructor() { }
  save(subscriptionDTO: SubscriptionDto) : Observable<any> {
    return this.subscriptionResourceService.save(subscriptionDTO);
  }

}
