import { Question } from './../models/question';
import { Author } from './../models/author';
import { Answer } from './../models/answer';
import { environment } from './../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { Book } from '../models/book';
import { AuthService } from './auth.service';
import { Category } from '../models/category';
import { Post } from '../models/post';
import { Review } from '../models/review';
import { User } from '../models/user';

@Injectable({
  providedIn: 'root'
})
export class BooknookService {

  constructor(private http: HttpClient, private auth: AuthService) { }

  url = environment.baseUrl + "api/";

  getHttpOptions() {
    let options = {
      headers: {
        Authorization: 'Basic ' + this.auth.getCredentials(),
        'X-Requested-With': 'XMLHttpRequest',
      },
    };
    return options;
  }

  // Answer mappings

  showAnswer(id: number) {
    return this.http.get<Answer>(this.url + "answers/" + id, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not return the Answer');
      })
    );
  }

  showAnswerList() {
    return this.http.get<Answer[]>(this.url + "answers", this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not return the list of Answers');
      })
    );
  }

  postAnswer(answer: Answer) {
    return this.http.post<Answer>(this.url + "answers", answer, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not post the Answer');
      })
    );
  }

  updateAnswer(answer: Answer, id: number) {
    return this.http.put<Answer>(this.url + "answers/" + id, answer, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not update the Answer');
      })
    );
  }

  removeAnswer(id: number) {
    return this.http.delete<Answer>(this.url + "answers/" + id, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not remove the Answer');
      })
    );
  }

    // Book mappings

    showBook(id: number) {
      return this.http.get<Book>(this.url + "books/" + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the Book');
        })
      );
    }

    showBookList() {
      return this.http.get<Book[]>(this.url + "books", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of Books');
        })
      );
    }

    postBook(book: Book) {
      return this.http.post<Book>(this.url + "books", book, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not post the Book');
        })
      );
    }

    updateBook(book: Book, id: number) {
      return this.http.put<Book>(this.url + "books/" + id, book, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not update the Book');
        })
      );
    }

    removeBook(id: number) {
      return this.http.delete<Book>(this.url + "books/" + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not remove the Book');
        })
      );
    }

    showBookCategories(id: number) {
      return this.http.get<Category[]>(this.url + "books/" + id + "/categories", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of Categories');
        })
      );
    }

    showBookAuthors(id: number) {
      return this.http.get<Author[]>(this.url + "books/" + id + "/authors", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of Authors');
        })
      );
    }

    // Comment mappings

  showComment(id: number) {
    return this.http.get<Comment>(this.url + "comments/" + id, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not return the Comment');
      })
    );
  }

  showCommentList() {
    return this.http.get<Comment[]>(this.url + "comments", this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not return the list of Comments');
      })
    );
  }

  postComment(comment: Comment) {
    return this.http.post<Answer>(this.url + "comments", comment, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not post the Comment');
      })
    );
  }

  updateComment(comment: Comment, id: number) {
    return this.http.put<Comment>(this.url + "comments/" + id, comment, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not update the Comment');
      })
    );
  }

  removeComment(id: number) {
    return this.http.delete<Comment>(this.url + "comments/" + id, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not remove the Comment');
      })
    );
  }

  // Post mappings

  showPost(id: number) {
    return this.http.get<Post>(this.url + "posts/" + id, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not return the Post');
      })
    );
  }

  showPostList() {
    return this.http.get<Post[]>(this.url + "posts", this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not return the list of Posts');
      })
    );
  }

  postPost(post: Post) {
    return this.http.post<Post>(this.url + "answers", post, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not post the Post');
      })
    );
  }

  updatePost(post: Post, id: number) {
    return this.http.put<Post>(this.url + "posts/" + id, post, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not update the Post');
      })
    );
  }

  removePost(id: number) {
    return this.http.delete<Post>(this.url + "posts/" + id, this.getHttpOptions())
    .pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Could not remove the Post');
      })
    );
  }

    // Question mappings

    showQuestion(id: number) {
      return this.http.get<Question>(this.url + "questions/" + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the Question');
        })
      );
    }

    showQuestionList() {
      return this.http.get<Question[]>(this.url + "questions", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of Questions');
        })
      );
    }

    postQuestion(question: Question) {
      return this.http.post<Question>(this.url + "questions", question, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not post the Question');
        })
      );
    }

    updateQuestion(question: Question, id: number) {
      return this.http.put<Question>(this.url + "questions/" + id, question, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not update the Question');
        })
      );
    }

    removeQuestion(id: number) {
      return this.http.delete<Question>(this.url + "questions/" + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not remove the Question');
        })
      );
    }

        // Review mappings

        showReview(id: number) {
          return this.http.get<Review>(this.url + "reviews/" + id, this.getHttpOptions())
          .pipe(
            catchError((err: any) => {
              console.log(err);
              return throwError('Could not return the Review');
            })
          );
        }

        showReviewList() {
          return this.http.get<Review[]>(this.url + "reviews", this.getHttpOptions())
          .pipe(
            catchError((err: any) => {
              console.log(err);
              return throwError('Could not return the list of Reviews');
            })
          );
        }

        postReview(review: Review) {
          return this.http.post<Review>(this.url + "reviews", review, this.getHttpOptions())
          .pipe(
            catchError((err: any) => {
              console.log(err);
              return throwError('Could not post the Review');
            })
          );
        }

        updateReview(review: Review, id: number) {
          return this.http.put<Review>(this.url + "reviews/" + id, review, this.getHttpOptions())
          .pipe(
            catchError((err: any) => {
              console.log(err);
              return throwError('Could not update the Review');
            })
          );
        }

        removeReview(id: number) {
          return this.http.delete<Review>(this.url + "reviews/" + id, this.getHttpOptions())
          .pipe(
            catchError((err: any) => {
              console.log(err);
              return throwError('Could not remove the Review');
            })
          );
        }


    // User mappings

    showUser(id: number) {
      return this.http.get<User>(this.url + "users/" + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the User');
        })
      );
    }

    showUserList() {
      return this.http.get<User[]>(this.url + "users", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of Users');
        })
      );
    }

    postUser(user: User) {
      return this.http.post<User>(this.url + "users", user, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not post the User');
        })
      );
    }

    updateUser(user: User, id: number) {
      return this.http.put<User>(this.url + "users/" + id, user, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not update the User');
        })
      );
    }

    removeUser(id: number) {
      return this.http.delete<User>(this.url + "users/" + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not remove the User');
        })
      );
    }

    showUserCategories(id: number) {
      return this.http.get<Category[]>(this.url + "users/" + id + "/categories", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of Categories');
        })
      );
    }

    showUserAuthors(id: number) {
      return this.http.get<Author[]>(this.url + "users/" + id + "/authors", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of Users');
        })
      );
    }

    showUserFavoriteBooks(id: number) {
      return this.http.get<Book[]>(this.url + "users/" + id + "/favoritebooks", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of favorite books');
        })
      );
    }

    showUserFinishedBooks(id: number) {
      return this.http.get<Book[]>(this.url + "users/" + id + "/finishedbooks", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of finished books');
        })
      );
    }

    showUserWishlistBooks(id: number) {
      return this.http.get<Book[]>(this.url + "users/" + id + "/wishlistbooks", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of wishlist books');
        })
      );
    }

    showUserReadingBooks(id: number) {
      return this.http.get<Book[]>(this.url + "users/" + id + "/readingbooks", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of reading books');
        })
      );
    }

    showUserFollowers(id: number) {
      return this.http.get<User[]>(this.url + "users/" + id + "/followers", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of followers');
        })
      );
    }

    showUserFollowing(id: number) {
      return this.http.get<User[]>(this.url + "users/" + id + "/followedUsers", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of users following');
        })
      );
    }

    // Category mappings

    showCategory(id: number) {
      return this.http.get<Category>(this.url + "categories/" + id, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the Category');
        })
      );
    }

    showCategoryList() {
      return this.http.get<Category[]>(this.url + "categories", this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not return the list of Categories');
        })
      );
    }

    // User wishlist mappings

    postWishlist(books: Book[], id: number) {
      return this.http.put<Book[]>(this.url + "users/" + id + "/wishlistbooks", books, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not create the wishlist item');
        })
      );
    }

    removeWishlist(userId: number, bookId: number) {
      return this.http.delete<Book[]>(this.url + "users/"+userId+"/wishlistbooks/"+bookId, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not remove book from the users wishlist');
        })
      );
    }

    // User reading mappings

    postReading(book: Book, id: number) {
      return this.http.post<Book[]>(this.url + "users/"+id+"/readingbooks/", book, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not create the reading item');
        })
      );
    }

    removeReading(userId: number, bookId: number) {
      return this.http.delete<Book[]>(this.url + "users/"+userId+"/readingbooks/"+bookId, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not remove book from the users currently reading');
        })
      );
    }

    // User favorites mappings

    postFavorite(book: Book, id: number) {
      return this.http.post<Book[]>(this.url + "users/"+id+"/favoritebooks/", book, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not create the favorite item');
        })
      );
    }

    removeFavorite(userId: number, bookId: number) {
      return this.http.delete<Book[]>(this.url + "users/"+userId+"/favoritebooks/"+bookId, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not remove book from the users favorite books');
        })
      );
    }

    // User finished mappings

    postFinished(book: Book, id: number) {
      return this.http.post<Book[]>(this.url + "users/"+id+"/finishedbooks/", book, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not create the finished item');
        })
      );
    }

    removeFinished(userId: number, bookId: number) {
      return this.http.delete<Book[]>(this.url + "users/"+userId+"/finishedbooks/"+bookId, this.getHttpOptions())
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not remove book from the users finished books');
        })
      );
    }

}
