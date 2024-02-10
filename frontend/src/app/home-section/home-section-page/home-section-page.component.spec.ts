import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HomeSectionPageComponent } from './home-section-page.component';

describe('HomeSectionPageComponent', () => {
  let component: HomeSectionPageComponent;
  let fixture: ComponentFixture<HomeSectionPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HomeSectionPageComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(HomeSectionPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
