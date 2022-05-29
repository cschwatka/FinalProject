import { Pipe, PipeTransform } from '@angular/core';
import { Book } from '../models/book';
import { Category } from '../models/category';

@Pipe({
  name: 'category',
  pure: false
})
export class CategoryPipe implements PipeTransform {

  transform(books: Book[], categories: Category[]): Book[] {
    if (categories.length === 0) {
      return books;
    } else {
      return books.filter(book => categories.some(category => book.categories.some(category1 => category.name.toLowerCase() === category1.name.toLowerCase())));
    }
  }

}
