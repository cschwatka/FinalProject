import { BooknookService } from './../../services/booknook.service';
import { Component, OnInit } from '@angular/core';
import { Book } from 'src/app/models/book';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {

  constructor(private bookSvc: BooknookService) { }

  books: Book[] = [];

  ngOnInit(): void {
    this.fetch();
  }

  fetch() {
    for (let i = 0; i < 120; i+=40) {
      this.bookSvc.fetch(i).subscribe(
        (next) => {this.parseData(next)},
        (error) => console.log("Observable error fetching book data.")
      )
    }
  }

  parseData(data: Book[]) {
    let newBook = {title: ""};

    for (let i = 0; i < data.length; i++) {
      // newBook.title = data["volumeInfo"]["title"];
    }
  }

}
