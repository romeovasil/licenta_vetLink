import {Component, inject} from '@angular/core';
import {MatDialogActions, MatDialogContent, MatDialogTitle} from "@angular/material/dialog";
import {MatButton} from "@angular/material/button";
import {ButtonModule} from "primeng/button";
import {FormsModule, NgForm, ReactiveFormsModule} from "@angular/forms";
import {InputTextModule} from "primeng/inputtext";
import {ShopItemDto} from "../domain/shop-item-dto";
import {DropdownModule} from "primeng/dropdown";
import { MessageService } from 'primeng/api';


import {CommonModule} from "@angular/common";
import {FormUtils} from "../../utils/form-utils";
import {HttpClient, HttpClientModule, HttpHeaders} from "@angular/common/http";
import {Router, RouterModule} from "@angular/router";
import {ToastModule} from "primeng/toast";
import {FileUploadModule} from "primeng/fileupload";


const headers = new HttpHeaders()
  .set('content-type', 'application/json')
  .set('Access-Control-Allow-Origin', '*');

@Component({
  selector: 'app-add-shop-item-popup',
  standalone: true,
  imports: [
    CommonModule,
    MatDialogTitle,
    MatDialogContent,
    MatDialogActions,
    MatButton,
    ButtonModule,
    FormsModule,
    InputTextModule,
    ReactiveFormsModule,
    DropdownModule,
    HttpClientModule,
    RouterModule,
    ToastModule,
    FileUploadModule
  ],
  templateUrl: './add-shop-item-popup.component.html',
  styleUrl: './add-shop-item-popup.component.scss',
  providers: [MessageService]
})
export class AddShopItemPopupComponent {


  shopItemDTO: ShopItemDto = new ShopItemDto();
  categories: string[] = ['Mancare','Jucarii','Ingrijire','Accesorii','Tratement'];
  http = inject(HttpClient);
  router = inject(Router);
  constructor() {}

  onSubmit(shopItemForm: NgForm) {
    FormUtils.markAllAsDirty(shopItemForm.form);
    FormUtils.markAllAsTouched(shopItemForm.form);
    if (shopItemForm.valid) {
      const token = localStorage.getItem("token");

      const authHeaders = headers.set('Authorization', `Bearer ${token}`);


      this.http.post('http://localhost:8080/api/v1/shop-item',this.shopItemDTO, {headers:authHeaders}).subscribe(
        (res: any) => {
          this.router.navigate(["/shop"]);
        },
        (error) => {
          console.error('Error:', error);
        }
      );
    }

  }


}
