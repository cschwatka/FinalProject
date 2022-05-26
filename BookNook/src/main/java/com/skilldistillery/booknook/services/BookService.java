package com.skilldistillery.booknook.services;

import java.util.List;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Category;

public interface BookService {

	public Book getBookById(int bookId);
	
	public List<Book> index();
	
	public Book update(int bookId, Book book);
	
	public Book destroy(int bookId);
	
	public List<Category> categories(int bookId);

	public List<Author> authors(int bookId);

}
