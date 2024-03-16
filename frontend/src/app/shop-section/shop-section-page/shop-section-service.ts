import {inject, Injectable} from "@angular/core";
import {ShopItemResourceService} from "../../utils/resource-service/shop-item-resource-service";
import {Observable} from "rxjs";

@Injectable({
  providedIn: 'root',
})
export class ShopSectionService {
  private shopItemResourceService = inject(ShopItemResourceService);


  findAll() : Observable<any>{
    return this.shopItemResourceService.findAll();
  }
}
