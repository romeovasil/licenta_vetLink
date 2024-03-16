import {Component, EventEmitter, inject, Input, Output} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {CardModule} from "primeng/card";
import {SharedModule} from "primeng/api";
import {ShopItemDto} from "../../domain/shop-item-dto";
import {HttpClient, HttpClientModule, HttpHeaders} from "@angular/common/http";
const headers = new HttpHeaders()
  .set('content-type', 'application/json')
  .set('Access-Control-Allow-Origin', '*');
@Component({
  selector: 'app-shop-item-card',
  standalone: true,
    imports: [
        ButtonModule,
        CardModule,
        SharedModule,
        HttpClientModule
    ],
  templateUrl: './shop-item-card.component.html',
  styleUrl: './shop-item-card.component.scss'
})
export class ShopItemCardComponent {
  @Input() shopItem: ShopItemDto | null = null;
  @Output() delete : EventEmitter<any> = new EventEmitter<any>();
  http = inject(HttpClient);
  deleteShopItem($event: number | null | undefined) {
    this.delete.emit($event);
  }
}
