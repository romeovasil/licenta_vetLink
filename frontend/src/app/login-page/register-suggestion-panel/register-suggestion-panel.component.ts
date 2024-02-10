import {Component, inject} from '@angular/core';
import {ButtonModule} from "primeng/button";
import {Router} from "@angular/router";

@Component({
  selector: 'app-register-suggestion-panel',
  standalone: true,
  imports: [
    ButtonModule
  ],
  templateUrl: './register-suggestion-panel.component.html',
  styleUrl: './register-suggestion-panel.component.scss'
})
export class RegisterSuggestionPanelComponent {
  router = inject(Router);
  goToSignUp() {
    this.router.navigate(['/register']);
  }
}
