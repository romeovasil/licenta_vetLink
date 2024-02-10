import {Component, Input, OnDestroy, OnInit} from "@angular/core";
import { Subject, takeUntil} from "rxjs";
import {Router} from "@angular/router";
import {ButtonModule} from "primeng/button";
import {NgClass} from "@angular/common";

@Component({
  selector: 'app-sidenav',
  standalone: true,
  imports: [
    ButtonModule,
    NgClass
  ],
  templateUrl: './sidenav.component.html',
  styleUrl: './sidenav.component.scss'
})
export class SidenavComponent implements OnInit, OnDestroy {

  @Input() collapsed = false;



  private destroy$: Subject<boolean> = new Subject();

  mobileMenu = false;

  constructor( private router:Router) { }



  ngOnInit() {


    this.router.events
      .pipe(
        takeUntil(this.destroy$)
      )
      .subscribe(event => {

      })
  }

  close() {
    this.collapsed = true;

  }

  open() {
    this.collapsed = false;

  }


  toggleMobileMenu() {
    this.mobileMenu = !this.mobileMenu;
  }

  closeMobileMenu() {
    this.mobileMenu = false;
  }

  ngOnDestroy(): void {
    this.destroy$.next(true)
  }
}
