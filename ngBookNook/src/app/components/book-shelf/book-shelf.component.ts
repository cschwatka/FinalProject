import { BooknookService } from './../../services/booknook.service';
import { Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { Book } from 'src/app/models/book';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-book-shelf',
  templateUrl: './book-shelf.component.html',
  styleUrls: ['./book-shelf.component.css']
})
export class BookShelfComponent implements OnInit {
  books: Book[] = [];
  following: User[] = [];

  constructor(
    private router: Router,
    private bnServ: BooknookService) { }

  ngOnInit(): void {
    this.reload();
    this.checkFollowing();
  }

  displayBook(id: number) {
    this.router.navigateByUrl("/displaybook/" + id)
  }

  reload(){
    this.bnServ.showBookList().subscribe(
      next => this.books = next,
      err => console.log("error retrieving book list" + err)
    )

  }

  checkFollowing(){
    let id = localStorage.getItem("userId");
    if(id != null){
      this.bnServ.showUserFollowing(parseInt(id)).subscribe(
        next => {this.following = next},
        err => console.log("error retrieving book list" + err)
      )
    }
    // return atob(this.getCredentials());
  }

  followingBooks(book1: Book){
    for(let user of this.following){
      for(let book of user.readingBooks){
        if(book1.title === book.title){
          return user.firstName + " is currently reading this book";
        }
      }
    }
    return "Be the first of your friends to read this!";
  }


}
