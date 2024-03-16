import {inject, Injectable} from "@angular/core";
import {AbstractResourceService} from "./abstract-resource-service";
import {HttpClient} from "@angular/common/http";
import {SubscriptionDto} from "../../subscription-section/domain/subscription-dto";

@Injectable({
  providedIn: 'root',
})
export class SubscriptionResourceService extends AbstractResourceService<SubscriptionDto> {

  constructor(httpClient: HttpClient) {
    super(
      httpClient,
      "subscription"
    );
  }

}
