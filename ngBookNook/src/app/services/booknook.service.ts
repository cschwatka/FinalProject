import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { Book } from '../models/book';

@Injectable({
  providedIn: 'root'
})
export class BooknookService {

  constructor(private http: HttpClient) { }

  url = "https://www.googleapis.com/books/v1/volumes?q=''&startIndex=&maxResults=";

  fetch(i: number) {
      this.url = 'https://www.googleapis.com/books/v1/volumes?q=""&startIndex=' + i + '&maxResults=40';
      return this.http.get<any>(this.url).pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('Could not list all books');
        })
      )
  }

}
