import { Review } from './../../models/review';
import { BooknookService } from './../../services/booknook.service';
import { Book } from 'src/app/models/book';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-book-page',
  templateUrl: './book-page.component.html',
  styleUrls: ['./book-page.component.css']
})
export class BookPageComponent implements OnInit {

selected: Book | null = null;
wishlistDisabled: boolean = false;
readingDisabled: boolean = false;
finishedDisabled: boolean = false;
favoriteDisabled: boolean = false;
user: User | null = null;
newReview: Review = new Review();
reviews: Review[] = [];
searchText: string='';

  constructor(
    private route: ActivatedRoute,
    private service: BooknookService,
    private svc: BooknookService
  ) { }

show(id: number){
  this.reviews = [];
  this.service.showBook(id).subscribe(
    (data) => {this.selected = data;
    for(let review of this.selected.reviews){
      if(review.enabled === true){
        this.reviews.push(review);
      }
    }},
    (error) => console.log("Observable error showing book for selected book: " + error)
  )
}

wishlistAdd(book: Book) {
  let userId = localStorage.getItem("userId");
  let id = 0;
  let rejected = false;
  if (userId !== null && this.user !== null) {
    id = parseInt(userId);
    for (let book1 of this.user.wishlistBooks) {
      if (book1.id === book.id) {
        rejected = true;
        break;
      }
    }
  }
  if (rejected === false && this.user !== null) {

   this.service.postWishlist(book, this.user.id).subscribe(
     (data) => {if (this.selected !== null && this.user !== null) {
        this.checkUser(this.selected.id, this.user.id);
     }},
     (err) => console.log(err)
   )
  }
}

checkWishlist(book: Book){
  let userId = localStorage.getItem("userId");
      let id = 0;
      let rejected = false;
      if (userId !== null && this.user !== null) {
        id = parseInt(userId);
        for (let book1 of this.user.wishlistBooks) {
          if (book1.id === book.id) {
            rejected = true;
            break;
          }
        }
      }
      return rejected;
}

wishlistAddOrRemove(book: Book){
  // let userId = localStorage.getItem("userId");
  // let id = 0;
    if (this.checkWishlist(book) === false && this.user !== null) {
      console.log("inside if statement")
      this.service.postWishlist(book, this.user.id).subscribe(
        (data) => {if (this.selected !== null && this.user !== null) {
          this.checkUser(this.selected.id, this.user.id);
        }},
        (err) => console.log(err)
        )
      }
      else if (this.checkWishlist(book) === true && this.user !== null) {
      console.log("inside else-if statement")
      this.service.removeWishlist(this.user.id, book.id).subscribe(
        (data) => {if (this.selected !== null && this.user !== null) {
          this.checkUser(this.selected.id, this.user.id);
     }},
     (err) => console.log(err)
   )
}
}

readingAdd(book: Book) {
  let userId = localStorage.getItem("userId");
  let id = 0;
  let rejected = false;
  if (userId !== null && this.user !== null) {
    id = parseInt(userId);
    for (let book1 of this.user.readingBooks) {
      if (book1.id === book.id) {
        rejected = true;
        break;
      }
    }
  }
  if (rejected === false && this.user !== null) {

   this.service.postReading(book, this.user.id).subscribe(
     (data) => {if (this.selected !== null && this.user !== null) {
        this.checkUser(this.selected.id, this.user.id);
     }},
     (err) => console.log(err)
   )
  }
}

finishedAdd(book: Book) {
  let userId = localStorage.getItem("userId");
  let id = 0;
  let rejected = false;
  if (userId !== null && this.user !== null) {
    id = parseInt(userId);
    for (let book1 of this.user.finishedBooks) {
      if (book1.id === book.id) {
        rejected = true;
        break;
      }
    }
  }
  if (rejected === false && this.user !== null) {

   this.service.postFinished(book, this.user.id).subscribe(
     (data) => {if (this.selected !== null && this.user !== null) {
        this.checkUser(this.selected.id, this.user.id);
     }},
     (err) => console.log(err)
   )
  }
}

favoritesAdd(book: Book) {
  let userId = localStorage.getItem("userId");
  let id = 0;
  let rejected = false;
    if (userId !== null && this.user !== null) {
      id = parseInt(userId);
      for (let book1 of this.user.favoriteBooks) {
        if (book1.id === book.id) {
          rejected = true;
          break;
        }
      }
    }
    if (rejected === false && this.user !== null) {
      this.service.postFavorite(book, this.user.id).subscribe(
        (data) => {if (this.selected !== null && this.user !== null) {
          this.checkUser(this.selected.id, this.user.id);
          console.log(this.favoriteDisabled);
        }},
        (err) => console.log(err)
        )
      }
    }

    favoritesRemove(book: Book) {
      let userId = localStorage.getItem("userId");
      let id = 0;
      let rejected = false;
      if (userId !== null && this.user !== null) {
        id = parseInt(userId);
        for (let book1 of this.user.favoriteBooks) {
          if (book1.id === book.id) {
            rejected = true;
            break;
          }
        }
      }
      if (rejected === true && this.user !== null) {
        this.service.removeFavorite(this.user.id, book.id).subscribe(
          (data) => {if (this.selected !== null && this.user !== null) {
            this.checkUser(this.selected.id, this.user.id);
            console.log(this.favoriteDisabled);
       }},
       (err) => console.log(err)
     )
  }
}

checkFavorite(book: Book){
  let userId = localStorage.getItem("userId");
      let id = 0;
      let rejected = false;
      if (userId !== null && this.user !== null) {
        id = parseInt(userId);
        for (let book1 of this.user.favoriteBooks) {
          if (book1.id === book.id) {
            rejected = true;
            break;
          }
        }
      }
      return rejected;
}

favoritesAddOrRemove(book: Book){
  // let userId = localStorage.getItem("userId");
  // let id = 0;
    if (this.checkFavorite(book) === false && this.user !== null) {
      console.log("inside if statement")
      this.service.postFavorite(book, this.user.id).subscribe(
        (data) => {if (this.selected !== null && this.user !== null) {
          this.checkUser(this.selected.id, this.user.id);
        }},
        (err) => console.log(err)
        )
      }
      else if (this.checkFavorite(book) === true && this.user !== null) {
      console.log("inside else-if statement")
      this.service.removeFavorite(this.user.id, book.id).subscribe(
        (data) => {if (this.selected !== null && this.user !== null) {
          this.checkUser(this.selected.id, this.user.id);
     }},
     (err) => console.log(err)
   )
}
}

favoriteCount(): number {
  if (this.selected != null){
    return this.selected.favoriteUsers.length;
  }
  else {
    return 0;
  }
}

showUser(id: number) {
  this.service.showUser(id).subscribe(
    (data) => {this.user = data;
    },
    (err) => console.log(err)
  )
}

checkUser(id: number, userId: number) {
  // let user: User = new User();

  this.service.showUser(userId).subscribe(
    (data) => {this.user = data; this.checkLists(id, this.user);
      // console.log(user.favoriteBooks)
    },
    (err) => console.log(err)
    )
  }

  checkLists(id: number, user: User | null) {

    if (user !== null) {

      let list: Book[] = user.wishlistBooks;
      this.wishlistDisabled = false;
      if (this.selected !== null) {
        for (let book of list) {
          if (book.id === this.selected.id) {
            this.wishlistDisabled = true;
            break;
          }
        }
      }
      this.readingDisabled = false;
      list = user.readingBooks;
      if (this.selected !== null) {
        for (let book of list) {
          if (book.id === this.selected.id) {
            this.readingDisabled = true;
            break;
          }
        }
      }

      list = user.finishedBooks;
      console.log(user.finishedBooks);

      this.finishedDisabled = false;
      if (this.selected !== null) {
        for (let book of list) {
          if (book.id === this.selected.id) {
            this.finishedDisabled = true;
            break;
          }
        }
      }

      this.favoriteDisabled = false;
      list = user.favoriteBooks;
      if (this.selected !== null) {
        for (let book of list) {
          if (book.id === this.selected.id) {
            this.favoriteDisabled = true;
            break;
          }
        }
      }
    }

    }

    ngOnInit(): void {
      let id: string | null = null;
      if (!this.selected && this.route.snapshot.paramMap.get('id')) {
        id = this.route.snapshot.paramMap.get('id');
        if (id) {
          this.show(parseInt(id));
        }
      }
      let userId = localStorage.getItem("userId");
      if (id !== null && userId !== null) {
      console.log(id + " " + userId);
      this.showUser(parseInt(userId));
      this.checkUser(parseInt(id), parseInt(userId));
    }
    if(this.selected != null){
    this.show(this.selected.id)
    }
  }


  makeReview() {
    if(this.user != null){
      this.newReview.user = this.user;
    }
    if(this.selected != null){
  this.service.postReview(this.newReview, this.selected.id).subscribe(
      (success) => {if(this.selected != null){
        this.show(this.selected.id)
        }
        this.newReview = new Review()},
      (err) => console.log(err)
    )
  }
}

progressBar(num: number){
  let count = 0;
  for(let review of this.reviews){
    if(review.rating === num){
      count++
    }
  }
  let sum = (count/this.reviews.length) * 100
  return sum;
}

progressCount(num: number){
  let count = 0;
  for(let review of this.reviews){
    if(review.rating === num){
      count++
    }
  }
  return count;
}

overallRating(){
  let sum = 0;
  for(let review of this.reviews){
    sum += review.rating;
  }
  return sum/this.reviews.length;
}

overallRatingFlat(){
  let sum = 0;
  for(let review of this.reviews){
    sum += review.rating;
  }
  return Math.floor(sum/this.reviews.length);
}

removeReview(review: Review) {
  this.service.removeReview(review.id).subscribe(
    (success) => { if (this.selected !== null) {
      this.show(this.selected.id)
    }},
    (err) => console.log(err)
  )
}


}
