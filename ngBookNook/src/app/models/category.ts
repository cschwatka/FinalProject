import { Book } from "./book";
import { User } from "./user";

export class Category {
  id: number;
  name: string;
  description: string;
  imgUrl: string;
  books: Book[];
  users: User[];

  constructor(

    id: number=0,
    name: string='',
    description: string='',
    imgUrl: string='',
    books: Book[] = [],
    users: User[] = [],

  ) {

    this.id = id;
    this.name = name;
    this.description = description;
    this.imgUrl = imgUrl;
    this.books = books;
    this.users = users;

  }

}
