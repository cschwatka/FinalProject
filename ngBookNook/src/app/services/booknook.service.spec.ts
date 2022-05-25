import { TestBed } from '@angular/core/testing';

import { BooknookService } from './booknook.service';

describe('BooknookService', () => {
  let service: BooknookService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(BooknookService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
