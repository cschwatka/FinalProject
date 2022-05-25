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

  books: any[] = [];

  ngOnInit(): void {
    this.fetch();
  }

  fetch() {
    for (let i = 0; i < 120; i+=40) {
      this.bookSvc.fetch(i).subscribe(
        (data) => {this.parseData(data);
        },
        (error) => console.log("Observable error fetching book data " + error)
      )
    }
  }

  parseData(data: any) {
    for (let i = 0; i < data["items"].length; i++) {
      console.log(data["items"][i]);
    }
  }
}
