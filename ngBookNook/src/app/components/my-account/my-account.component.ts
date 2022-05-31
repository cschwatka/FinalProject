import { Router, ActivatedRoute } from '@angular/router';
import { Book } from 'src/app/models/book';
import { AuthService } from 'src/app/services/auth.service';
import { BooknookService } from 'src/app/services/booknook.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { finalize } from 'rxjs';
import { Post } from 'src/app/models/post';

@Component({
  selector: 'app-my-account',
  templateUrl: './my-account.component.html',
  styleUrls: ['./my-account.component.css']
})
export class MyAccountComponent implements OnInit {

  user: User | null = null;
  wishlistBooks: Book[] = [];
  finishedBooks: Book[] = [];
  favoriteBooks: Book[] = [];
  readingBooks: Book[] = [];
  posts: Post[] = [];
  wishlist: boolean = false;
  favorites: boolean = false;
  finished: boolean = false;
  reading: boolean = false;
  postsEnabled: boolean = false;
  profile: boolean = false;

  constructor(private service: BooknookService, private auth: AuthService, private router: Router, private route: ActivatedRoute) { }

  ngOnInit(): void {
    let id = localStorage.getItem("userId");
    if (id !== null) {
      if (this.user === null) {
        this.showUser(parseInt(id));
      }
    }
    if (this.route.snapshot.paramMap.get('bind')) {
      let bind = this.route.snapshot.paramMap.get('bind');
      console.log(bind);
      if (bind) {
        this.operate(bind);
      }
    }
  }

  operate(bind: string) {
    if (bind === "none") {
      this.profile = true;
      this.wishlist = false;
      this.favorites = false;
      this.postsEnabled = false;
      this.finished = false;
      this.reading = false;
    } else if (bind === "profile") {
      this.profile = true;
      this.wishlist = false;
      this.favorites = false;
      this.postsEnabled = false;
      this.finished = false;
      this.reading = false;
    } else if (bind === "posts") {
      this.profile = false;
      this.wishlist = false;
      this.favorites = false;
      this.postsEnabled = true;
      this.finished = false;
      this.reading = false;
    } else if (bind === "wishlist") {
      this.profile = false;
      this.wishlist = true;
      this.favorites = false;
      this.postsEnabled = false;
      this.finished = false;
      this.reading = false;
    } else if (bind === "favorites") {
      this.profile = false;
      this.wishlist = false;
      this.favorites = true;
      this.postsEnabled = false;
      this.finished = false;
      this.reading = false;
    } else if (bind === "finished") {
      this.profile = false;
      this.wishlist = false;
      this.favorites = false;
      this.postsEnabled = false;
      this.finished = true;
      this.reading = false;
    } else if (bind === "reading") {
      this.profile = false;
      this.wishlist = false;
      this.favorites = false;
      this.postsEnabled = false;
      this.finished = false;
      this.reading = true;
    } else {
      this.profile = true;
      this.wishlist = false;
      this.favorites = false;
      this.postsEnabled = false;
      this.finished = false;
      this.reading = false;
    }
  }

  showUser(id: number) {
    this.service.showUser(id).subscribe(
      (data) => {this.user = data; this.wishlistBooks = this.user.wishlistBooks; this.finishedBooks = this.user.finishedBooks
      this.readingBooks = this.user.readingBooks; this.favoriteBooks = this.user.favoriteBooks; this.showPosts(this.user.posts)},
      (err) => console.log(err)
    )
  }

  showPosts(posts: Post[]) {
    this.posts = [];
    for (let post of posts) {
      if (post.enabled === true) {
        this.posts.push(post);
      }
    }
  }

  removeFromWishlist(book: Book) {
    if (this.user !== null) {
      this.service.removeWishlist(this.user.id, book.id).subscribe(
        (success) => {if (this.user !== null) {
          this.showUser(this.user.id)
        }},
        (err) => console.log(err)
      )
    }
  }

  removeFromReading(book: Book) {
    if (this.user !== null) {
      this.service.removeReading(this.user.id, book.id).subscribe(
        (success) => {if (this.user !== null) {
          this.showUser(this.user.id)
        }},
        (err) => console.log(err)
      )
    }
  }

  removeFromFavorite(book: Book) {
    if (this.user !== null) {
      this.service.removeFavorite(this.user.id, book.id).subscribe(
        (success) => {if (this.user !== null) {
          this.showUser(this.user.id)
        }},
        (err) => console.log(err)
      )
    }
  }

  removeFromFinished(book: Book) {
    if (this.user !== null) {
      this.service.removeFinished(this.user.id, book.id).subscribe(
        (success) => {if (this.user !== null) {
          this.showUser(this.user.id)
        }},
        (err) => console.log(err)
      )
    }
  }

  removeFromPost(post: Post) {
    if (this.user !== null) {
      this.service.removePost(post.id).subscribe(
        (success) => {if (this.user !== null) {
          this.showUser(this.user.id)
        }},
        (err) => console.log(err)
      )
    }
  }

  displayBook(book: Book){
    this.router.navigateByUrl("/displaybook/"+book.id);
  }

  displayPost(post: Post){
    this.router.navigateByUrl("/postview/"+post.id);
  }

}
