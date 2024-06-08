import {Component, EventEmitter, inject, OnInit, Output} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {FormsModule, NgForm} from "@angular/forms";
import {InputTextModule} from "primeng/inputtext";
import {MatButton} from "@angular/material/button";
import {MatDialogActions} from "@angular/material/dialog";
import {DropdownModule} from "primeng/dropdown";
import {CommonModule} from "@angular/common";
import {HttpClient, HttpClientModule} from "@angular/common/http";
import {Router} from "@angular/router";
import {ShopItemResourceService} from "../../../../utils/resource-service/shop-item-resource-service";
import {MultiSelectModule} from "primeng/multiselect";
import {SubscriptionDto} from "../../../domain/subscription-dto";
import {FormUtils} from "../../../../utils/form-utils";

@Component({
  selector: 'app-new-subscription-form',
  standalone: true,
  imports: [
    ButtonModule,
    FormsModule,
    InputTextModule,
    MatButton,
    MatDialogActions,
    DropdownModule,
    CommonModule,
    HttpClientModule,
    MultiSelectModule
  ],
  templateUrl: './new-subscription-form.component.html',
  styleUrl: './new-subscription-form.component.scss'
})
export class NewSubscriptionFormComponent implements OnInit {
  http = inject(HttpClient);
  router = inject(Router);
  shopItemDTOs : any= [];

  subscriptionDTO : SubscriptionDto = new SubscriptionDto();
  recurrence: string[] = ['Saptamanal','Lunar','Anual'];
  private shopItemResourceService = inject(ShopItemResourceService);

  @Output() submitForm: EventEmitter<SubscriptionDto> = new EventEmitter<SubscriptionDto>();

  onSubmit(subscriptionForm: NgForm) {
    FormUtils.markAllAsDirty(subscriptionForm.form);
    FormUtils.markAllAsTouched(subscriptionForm.form);
    if (subscriptionForm.valid) {
      console.log(this.subscriptionDTO)
      this.submitForm.emit(this.subscriptionDTO)
    }
  }

  ngOnInit(): void {
    this.shopItemResourceService.findAll().subscribe(
      res => this.shopItemDTOs = res
    )
  }
}
