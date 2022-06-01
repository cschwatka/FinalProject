import { Author } from "./author";
import { Category } from "./category";
import { Language } from "./language";
import { Review } from "./review";
import { User } from "./user";

export class Book {

  id: number;
  language: Language;
  title: string;
  description: string;
  enabled: boolean;
  isbn10: string;
  pageCount: number;
  imgUrl: string;
  publishDate: string;
  isbn13: string;
  dateAdded: string;
  lastUpdated: string;
  reviews: Review[];
  categories: Category[];
  authors: Author[];
  favoriteUsers: User[];
  finishedUsers: User[];
  readingUsers: User[];
  wishlistUsers: User[];

  constructor( id: number = 0,
    language: Language = new Language(),
    title: string = "",
    description: string = "",
    enabled: boolean = true,
    isbn10: string = "",
    pageCount: number = 0,
    imgUrl: string = "",
    publishDate: string = "",
    isbn13: string = "",
    dateAdded: string = "",
    lastUpdated: string = "",
    categories: Category[] = [],
    authors: Author[] = [],
    favoriteUsers: User[] = [],
    finishedUsers: User[] = [],
    readingUsers: User[] = [],
    wishlistUsers: User[] = [],
    reviews: Review [] = []) {

      this.id = id;
      this.language = language;
      this.title = title;
      this.description = description;
      this.enabled = enabled;
      this.isbn10 = isbn10;
      this.pageCount = pageCount;
      this.imgUrl = imgUrl;
      this.publishDate = publishDate;
      this.isbn13 = isbn13;
      this.dateAdded = dateAdded;
      this.lastUpdated = lastUpdated;
      this.categories = categories;
      this.authors = authors;
      this.favoriteUsers = favoriteUsers;
      this.finishedUsers = finishedUsers;
      this.readingUsers = readingUsers;
      this.wishlistUsers = wishlistUsers;
      this.language = language;
      this.reviews = reviews;

  }

}
