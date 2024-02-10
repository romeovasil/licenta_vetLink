import {Component, OnInit} from '@angular/core';
import {MatGridList, MatGridTile} from "@angular/material/grid-list";
import {RouterOutlet} from "@angular/router";

@Component({
  selector: 'app-home-page',
  standalone: true,
  imports: [
    MatGridTile,
    MatGridList,
    RouterOutlet
  ],
  templateUrl: './home-page.component.html',
  styleUrl: './home-page.component.scss'
})
export class HomePageComponent {

}
