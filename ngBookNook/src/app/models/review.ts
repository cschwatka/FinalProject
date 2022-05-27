import { i18nMetaToJSDoc } from "@angular/compiler/src/render3/view/i18n/meta";
import { Title } from "@angular/platform-browser";
import { Book } from "./book";
import { User } from "./user";

export class Review {
  id: number;
  book: Book;
  user: User;
  content: string;
  rating: number;
  enabled: boolean;
  title: string;
  reviewDate: string;

  constructor(
  id: number = 0,
  book: Book = new Book(),
  user: User = new User(),
  content: string = '',
  rating: number = 0,
  enabled: boolean = true,
  title: string = '',
  reviewDate: string = ''
  ){
this.id = id;
this.book = book;
this.user = user;
this.content = content;
this.enabled = enabled;
this.rating = rating;
this.title = title;
this.reviewDate = reviewDate;
  }

}
