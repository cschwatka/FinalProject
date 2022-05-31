import { Answer } from "./answer";
import { Author } from "./author";
import { Book } from "./book";
import { Category } from "./category";
import { Post } from "./post";
import { Review } from "./review";

export class User {
  id: number;
  username: string;
  password: string;
  enabled: boolean;
  role: string;
  email: string;
  firstName: string;
  lastName: string;
  imgUrl: string;
  biography: string;
  createDate: string;
  categories: Category[];
  authors: Author[];
  reviews: Review[];
  answers: Answer[];
  posts: Post[];
  comments: Comment[];
  favoriteBooks: Book[];
  finishedBooks: Book[];
  readingBooks: Book[];
  wishlistBooks: Book[];
  usersFollowing?: User[];
  followedUsers: User[];

  constructor(  id: number = 0,
    username: string = "",
    password: string = "",
    enabled: boolean = true,
    role: string = "",
    email: string = "",
    firstName: string = "",
    lastName: string = "",
    imgUrl: string = "",
    biography: string = "",
    createDate: string = "",
    categories: Category[] = [],
    authors: Author[] = [],
    reviews: Review[] = [],
    answers: Answer[] = [],
    posts: Post[] = [],
    comments: Comment[] = [],
    favoriteBooks: Book[] = [],
    finishedBooks: Book[] = [],
    readingBooks: Book[] = [],
    wishlistBooks: Book[] = [],
    usersFollowing: User[] = [],
    followedUsers: User[] = []) {

      this.id = id;
      this.username = username;
      this.password = password;
      this.enabled = enabled;
      this.role = role;
      this.email = email;
      this.firstName = firstName;
      this.lastName = lastName;
      this.imgUrl = imgUrl;
      this.biography = biography;
      this.createDate = createDate;
      this.categories = categories;
      this.authors = authors;
      this.reviews = reviews;
      this.answers = answers;
      this.posts = posts;
      this.comments = comments;
      this.favoriteBooks = favoriteBooks;
      this.finishedBooks = finishedBooks;
      this.readingBooks = readingBooks;
      this.wishlistBooks = wishlistBooks;
      this.usersFollowing = usersFollowing;
      this.followedUsers = followedUsers;

  }

}
