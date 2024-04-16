import {Component, inject, OnInit} from '@angular/core';
import OpenAI from "openai";
import {ButtonModule} from "primeng/button";
import {DragDropModule} from "primeng/dragdrop";
import {PanelModule} from "primeng/panel";
import {JsonPipe, NgForOf, NgIf} from "@angular/common";
import {PatientDto} from "../../patient-section/domain/patient-dto";
import {AppointmentSectionService} from "../../appointment-section/appointment-section.service";
import {AppointmentDto} from "../../appointment-section/domain/appointment-dto";
import {Notifications} from "@mobiscroll/angular";

@Component({
  selector: 'app-recommendations-page',
  standalone: true,
  imports: [
    ButtonModule,
    DragDropModule,
    PanelModule,
    NgForOf,
    NgIf,
    JsonPipe
  ],
  templateUrl: './recommendations-page.component.html',
  styleUrl: './recommendations-page.component.scss'
})
export class RecommendationsPageComponent implements OnInit {
  openAi = new OpenAI({apiKey: "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", dangerouslyAllowBrowser: true});
  receivedMessage: string | undefined = "";

  appointmentService = inject(AppointmentSectionService);
  patients: PatientDto[] = [];
  availablePets: Product[] = [];
  selectedPets: Product[] = [];
  availableAllergies: Product[] = [];
  selectedAllergies: Product[] = [];
  availableInvestigations: Product[] = [];
  selectedInvestigations: Product[] = [];
  draggedProduct: Product | undefined | null;
  notify = inject(Notifications);

  async getInfo() {
    if (this.selectedPets.length == 0) {
      this.notify.toast({
        message: "Selectati un animal"
      });
    } else if (this.selectedAllergies.length == 0) {
      this.notify.toast({
        message: "Selectati o alergie"
      });
    } else if (this.selectedInvestigations.length == 0) {
      this.notify.toast({
        message: "Selectati o investigatie"
      });
    }

    if (this.selectedInvestigations.length === 1 && this.selectedAllergies.length === 1 && this.selectedPets.length === 1) {

      const completion = await this.openAi.chat.completions.create({

        messages: [{
          role: "user",
          content: `Comporta-te cu mine ca si cum as fi veterinar .Fa mi o recomandare mie care sunt un veterinar despre " +
          "ce ar trebui făcut in cazul in care un ${this.selectedPets[0]} are alergie la ${this.selectedAllergies[0]}
           dar trebuie sa ii efectuam ${this.selectedInvestigations[0]} . " +
          "Eu sunt veterinarul, nu ma trimite la alt veterinar, sugestia ta nu ar trebui sa implice alt veterinar" +
          "Vreau sa fie de 30 de cuvinte si sa fie tehnic având in vedere ca eu sunt veterinarul." +
          " Nu mă trimite la veterinar sau nu imi spune ca un veterinar ar trebui consulat`
        }],
        model: "gpt-3.5-turbo",
      });

      this.receivedMessage = completion?.choices[0]?.message?.content?.toString();

    }

  }

  ngOnInit() {
    this.selectedPets = [];
    this.selectedAllergies = [];
    this.selectedAllergies = [];
    this.selectedInvestigations = [];

    this.availablePets = [];
    this.availableAllergies = [];
    this.availableInvestigations = [];

    let petIds = new Set<number>();
    let allergyIds = new Set<number>();
    let investigationIds = new Set<number>();

    this.appointmentService.findAll().subscribe(
      (res: AppointmentDto[]) => {
        this.availablePets = [];
        this.availableAllergies = [];
        this.availableInvestigations = [];

        res.forEach((item: AppointmentDto) => {
          if (item.patientDTO?.id && !petIds.has(item.patientDTO.id)) {
            let product = new Product();
            product.id = item.patientDTO.id;
            product.name = item.patientDTO.type + ' ' + item.patientDTO.race;
            this.availablePets.push(product);
            petIds.add(item.patientDTO.id);
          }

          if (item.patientDTO?.id && item.patientDTO.allergy && !allergyIds.has(item.patientDTO.id)) {
            let product = new Product();
            product.id = item.patientDTO.id;
            product.name = item.patientDTO.allergy;
            this.availableAllergies.push(product);
            allergyIds.add(item.patientDTO.id);
          }

          if (item.id && !investigationIds.has(item.id)) {
            let product = new Product();
            product.id = item.id;
            product.name = item.job;
            this.availableInvestigations.push(product);
            investigationIds.add(item.id);
          }
        });
      }
    );

  }

  dragStart(product: Product) {
    this.draggedProduct = product;
  }

  drop(type: string) {
    if (this.draggedProduct) {

      let draggedProductIndex = this.findIndex(this.draggedProduct, type);
      if (type === 'pet' && this.selectedPets?.length < 1) {
        this.selectedPets = [...(this.selectedPets as Product[]), this.draggedProduct];
        this.availablePets = this.availablePets?.filter((val, i) => i != draggedProductIndex);
      }

      if (type === 'allergy' && this.selectedAllergies?.length < 1) {
        this.selectedAllergies = [...(this.selectedAllergies as Product[]), this.draggedProduct];
        this.availableAllergies = this.availableAllergies?.filter((val, i) => i != draggedProductIndex);
      }

      if (type === 'investigation' && this.selectedInvestigations?.length < 1) {
        this.selectedInvestigations = [...(this.selectedInvestigations as Product[]), this.draggedProduct];
        this.availableInvestigations = this.availableInvestigations?.filter((val, i) => i != draggedProductIndex);
      }


      this.draggedProduct = null;
    }
  }

  dragEnd() {
    this.draggedProduct = null;
  }

  findIndex(product: Product, type: string) {
    let index = -1;

    if (type === 'pet') {
      for (let i = 0; i < (this.availablePets as Product[]).length; i++) {
        if (product.id === (this.availablePets as Product[])[i].id) {
          index = i;
          break;
        }
      }
    }

    if (type === 'allergy') {
      for (let i = 0; i < (this.availableAllergies as Product[]).length; i++) {
        if (product.id === (this.availableAllergies as Product[])[i].id) {
          index = i;
          break;
        }
      }
    }

    if (type === 'investigation') {
      for (let i = 0; i < (this.availableInvestigations as Product[]).length; i++) {
        if (product.id === (this.availableInvestigations as Product[])[i].id) {
          index = i;
          break;
        }
      }
    }

    return index;
  }


}


export class Product {
  id: number | null | undefined = null;
  name: string | null | undefined = null;
}
