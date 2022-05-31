import { Pipe, PipeTransform } from '@angular/core';
import { Book } from '../models/book';

@Pipe({
  name: 'pageCount'
})
export class PageCountPipe implements PipeTransform {

  transform(books: Book[], lowest: number, highest: number): Book[] {
    if (highest !== 0) {
      return books.filter((book) =>
        book.pageCount > lowest && book.pageCount < highest
      );
    } else {
      return books;
    }
  }

}
