import { Pipe, PipeTransform } from '@angular/core';
import { Book } from '../models/book';

@Pipe({
  name: 'searchCategory'
})
export class SearchCategoryPipe implements PipeTransform {

  transform(books: Book[], text: string): Book[] {
    if (text != '') {
      return books.filter((book) =>
        book.title.toLowerCase().includes(text.toLowerCase())

      );
    } else {
      return books;
    }
  }

}
