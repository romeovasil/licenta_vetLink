import {ShopItemDto} from "../../shop-section/domain/shop-item-dto";

export class SubscriptionDto{
  id : number | null = null;
  name: string | null = null;
  price: string | null = null;
  recurrence: string | null = null;
  shortDescription: string | null = null;
  shopItemDTOs: ShopItemDto[] = [];
  owner: string | null = null;

}
