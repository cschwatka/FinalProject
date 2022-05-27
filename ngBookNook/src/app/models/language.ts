import { Book } from "./book";

export class Language {
  id: number;
  name: string;
  books: Book[];

  constructor(
  id: number = 0,
  name: string = '',
  books: Book[] = []
  ){
  this.id = id;
  this.name = name;
  this.books = books
  }
}
