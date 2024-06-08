import { MbscModule } from '@mobiscroll/angular';
import {Component, OnInit} from '@angular/core';
import { CommonModule } from '@angular/common';
import {Router, RouterOutlet} from '@angular/router';
import {FormsModule} from "@angular/forms";
import {SliderModule} from "primeng/slider";
import {InputTextModule} from "primeng/inputtext";
import {MenubarModule} from "primeng/menubar";
import {ButtonModule} from "primeng/button";
import {MenuItem} from "primeng/api";
import {SidenavComponent} from "./sidenav/sidenav.component";
import {MatSidenavContainer, MatSidenavModule} from "@angular/material/sidenav";
import {MatGridList, MatGridTile} from "@angular/material/grid-list";
import {HttpClientModule} from "@angular/common/http";

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [MbscModule, CommonModule, RouterOutlet, FormsModule, SliderModule, InputTextModule, MenubarModule, ButtonModule, SidenavComponent, MatSidenavContainer, MatSidenavModule, MatGridList, MatGridTile, HttpClientModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent implements OnInit {
  items: MenuItem[] | undefined;
  constructor(private router: Router) {}

  isLoginPageOrRegisterPage(): boolean {
    return this.router.url.endsWith('/') || this.router.url.includes('/register');
  }
  ngOnInit() {
    this.items = [
      {
        label: 'Rezervari',
        icon: 'pi pi-fw pi-file',
        routerLink: '/appointments'
      },
      {
        label: 'Abonamente',
        icon: 'pi pi-fw pi-pencil',
        routerLink: '/subscriptions',

      },
      {
        label: 'Shop',
        icon: 'pi pi-fw pi-user',
        routerLink: '/shop'
      },
      {
        label: 'Doctori',
        icon: 'pi pi-fw pi-users',
        routerLink: '/doctors'
      },
      {
        label: 'Pacienti',
        icon: 'pi pi-fw pi-id-card',
        routerLink: '/patients'
      },
      {
        label: 'Recomandari',
        icon: 'pi pi-fw pi-book',
        routerLink: '/recommendations'
      }
    ];
  }

  logout() {
    localStorage.removeItem('token');
    this.router.navigate(['/']);
  }
}
