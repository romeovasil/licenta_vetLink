import {Component, inject, OnInit} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {MatFormField} from "@angular/material/form-field";
import {FormsModule} from "@angular/forms";
import {MatInput} from "@angular/material/input";
import {MatButton} from "@angular/material/button";
import {MatDialog} from "@angular/material/dialog";
import {AddShopItemPopupComponent} from "../add-shop-item-popup/add-shop-item-popup.component";
import {CommonModule} from "@angular/common";
import {HttpClient, HttpClientModule, HttpHeaders} from "@angular/common/http";
import {Router, RouterModule} from "@angular/router";
import {MatGridList, MatGridTile} from "@angular/material/grid-list";
import {CardModule} from "primeng/card";
import {ShopItemDto} from "../domain/shop-item-dto";
import {ShopItemCardComponent} from "./shop-item-card/shop-item-card.component";
import {DialogModule} from "primeng/dialog";
import {ShopSectionService} from "./shop-section-service";
import {Notifications} from "@mobiscroll/angular";
const headers = new HttpHeaders()
  .set('content-type', 'application/json')
  .set('Access-Control-Allow-Origin', '*');
@Component({
  selector: 'app-shop-section-page',
  standalone: true,
  imports: [
    ButtonModule,
    MatFormField,
    FormsModule,
    MatInput,
    MatButton,
    CommonModule,
    HttpClientModule,
    RouterModule,
    MatGridList,
    MatGridTile,
    CardModule,
    ShopItemCardComponent,
    DialogModule

  ],
  templateUrl: './shop-section-page.component.html',
  styleUrl: './shop-section-page.component.scss'
})
export class ShopSectionPageComponent implements OnInit{
  constructor(private dialog: MatDialog, private  shopService:ShopSectionService) {}

  http = inject(HttpClient);
  router = inject(Router);
  shopItemDtos: ShopItemDto[] = [];
  notify = inject(Notifications);
  visible: boolean = false;
  openPopup() {

    this.router.navigate(['shop', 'new']);
  }

  ngOnInit(): void {
      this.getAllShopItems();

  }

  showDialog() {
    this.visible = true
  }

  onDelete($event: any) {
    const token = localStorage.getItem("token");
    const authHeaders = headers.set('Authorization', `Bearer ${token}`);


    this.http.delete(`http://localhost:8080/api/v1/shop-item/${$event}`, {headers:authHeaders}).subscribe(
      (res: any) => {
        this.notify.toast({
          message: "Produs sters cu succes!"
          , color:"success"
        });
        this.getAllShopItems();
      },
      (error) => {
        this.notify.toast({
          message: "Produsul nu poate fi sters doarece face parte dintr-un abonament",
          color:"danger"
        });
      }
    );
  }

  getAllShopItems() {
    this.shopService.findAll().subscribe(
      res => this.shopItemDtos = res
    );
  }
}
