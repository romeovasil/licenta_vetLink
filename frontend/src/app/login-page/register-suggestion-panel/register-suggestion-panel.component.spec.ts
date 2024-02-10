import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RegisterSuggestionPanelComponent } from './register-suggestion-panel.component';

describe('RegisterSuggestionPanelComponent', () => {
  let component: RegisterSuggestionPanelComponent;
  let fixture: ComponentFixture<RegisterSuggestionPanelComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [RegisterSuggestionPanelComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(RegisterSuggestionPanelComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
