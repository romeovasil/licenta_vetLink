import { Injectable} from "@angular/core";
import {AbstractResourceService} from "./abstract-resource-service";
import {HttpClient} from "@angular/common/http";
import {ShopItemDto} from "../../shop-section/domain/shop-item-dto";

@Injectable({
  providedIn: 'root',
})
export class ShopItemResourceService extends AbstractResourceService<ShopItemDto> {

  constructor(httpClient: HttpClient) {
    super(
      httpClient,
      "shop-item"
    );
  }

}
