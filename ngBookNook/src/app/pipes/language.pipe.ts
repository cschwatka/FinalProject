import { RouterTestingModule } from '@angular/router/testing';
import { Book } from 'src/app/models/book';
import { Language } from './../models/language';
import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'language',
  pure: false
})
export class LanguagePipe implements PipeTransform {

  transform(books: Book[], languages: Language[]): Book[] {
    if (languages.length === 0) {
      return books;
    } else {
      return books.filter(book => languages.some(language => language.name.toLowerCase() === book.language.name.toLowerCase()));
    }
  }

}
