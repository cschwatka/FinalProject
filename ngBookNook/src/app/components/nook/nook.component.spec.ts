import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NookComponent } from './nook.component';

describe('NookComponent', () => {
  let component: NookComponent;
  let fixture: ComponentFixture<NookComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NookComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NookComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
