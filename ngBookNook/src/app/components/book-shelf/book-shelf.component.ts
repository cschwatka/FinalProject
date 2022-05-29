import { BooknookService } from './../../services/booknook.service';
import { Router } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { Book } from 'src/app/models/book';
import { User } from 'src/app/models/user';
import { Category } from 'src/app/models/category';

@Component({
  selector: 'app-book-shelf',
  templateUrl: './book-shelf.component.html',
  styleUrls: ['./book-shelf.component.css']
})
export class BookShelfComponent implements OnInit {
  books: Book[] = [];
  following: User[] = [];
  searchText: string='';
  categories: Category[] = [];
  filteredCategories: Category[] = [];
  bookCount: number = 0;

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

  displayCount(num: number) {
    this.bookCount = num;
  }

  findCount() {
    let bookCount = this.bookCount;
    setTimeout(() => {}
    , 0)
    return bookCount + 1;
  }

  reload(){
    this.bnServ.showBookList().subscribe(
      next => this.books = next,
      err => console.log("error retrieving book list" + err)
    )
    this.bnServ.showCategoryList().subscribe(
      next => this.categories = next,
      err => console.log("error retrieving book list" + err)
    )

  }

  check(category: Category) {
    let checked = false;
    for (let i in this.filteredCategories) {
      if (this.filteredCategories[i].name === category.name) {
        checked = true;
        this.filteredCategories.splice(parseInt(i), 1);
      }
    }
    if (checked === true) {
      checked = false;
    } else {
      this.filteredCategories.push(category);
    }

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
