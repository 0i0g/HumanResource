import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SlidemenuComponent } from './slidemenu.component';

describe('SlidemenuComponent', () => {
  let component: SlidemenuComponent;
  let fixture: ComponentFixture<SlidemenuComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SlidemenuComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(SlidemenuComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
