import { Pipe, PipeTransform } from '@angular/core';
import { Book } from '../models/book';

@Pipe({
  name: 'bookshelfSearch'
})
export class BookshelfSearchPipe implements PipeTransform {

  transform(books: Book[], text: string): Book[] {
    if (text != '') {
      return books.filter((book) =>
        book.title.toLowerCase().includes(text.toLowerCase())
        || book.isbn10.toLowerCase().includes(text.toLowerCase())
        || book.isbn13.toLowerCase().includes(text.toLowerCase())
        || book.authors.some(author => author.fullName.toLowerCase().includes(text.toLowerCase()))
        || (book.description != null && book.description.toLowerCase().includes(text.toLowerCase()))
      );
    } else {
      return books;
    }
  }

}
