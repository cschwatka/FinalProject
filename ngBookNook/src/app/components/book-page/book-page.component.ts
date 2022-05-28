import { BooknookService } from './../../services/booknook.service';
import { Book } from 'src/app/models/book';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-book-page',
  templateUrl: './book-page.component.html',
  styleUrls: ['./book-page.component.css']
})
export class BookPageComponent implements OnInit {

selected: Book | null = null;

  constructor(
    private route: ActivatedRoute,
    private service: BooknookService
  ) { }

show(id: number){
  this.service.showBook(id).subscribe(
    (data) => this.selected = data,
    (error) => console.log("Observable error showing book for selected book: " + error)
  )
}

  ngOnInit(): void {
    if (!this.selected && this.route.snapshot.paramMap.get('id')) {
      let id = this.route.snapshot.paramMap.get('id');
      if (id) {
        this.show(parseInt(id));
      }
    }
  }



}
