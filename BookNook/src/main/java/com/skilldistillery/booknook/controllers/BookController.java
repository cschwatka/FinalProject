package com.skilldistillery.booknook.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.entities.Review;
import com.skilldistillery.booknook.services.BookService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class BookController {
	
	@Autowired
	private BookService bookService;

	@GetMapping("books/{bookId}")
	public Book getBookById(
	  @PathVariable Integer bookId,
	  HttpServletResponse res
	) {
	  Book book = bookService.getBookById(bookId);
	  
	  if (book == null) {
	    res.setStatus(404);
	  }
	  return book;
	}
	
	@GetMapping("books")
	public List<Book> getListOfBooks(
			HttpServletResponse res,
			HttpServletRequest req
			) {
		List<Book> books = bookService.index();
		return books;
	}
	
	@PutMapping("books/{bookId}")
	public Book update(
			@PathVariable Integer bookId,
			@RequestBody Book book,
			HttpServletResponse res,
			HttpServletRequest req
			) {
		Book newBook = bookService.update(bookId, book);
		if (newBook == null) {
			res.setStatus(404);
		}
		return newBook;
	}
	
	@DeleteMapping("books/{bookId}")
	public Book destroy(
			@PathVariable Integer bookId,
			HttpServletResponse res
			) {
		Book deleteBook = bookService.destroy(bookId);
		if (deleteBook == null) {
			res.setStatus(404);
		}
		return deleteBook;
	}
	
	@GetMapping("books/{bookId}/categories")
	public List<Category> getCategoriesByBook(
			@PathVariable Integer bookId,
			HttpServletResponse res
			) {
		List<Category> categories = bookService.categories(bookId);
		if(categories == null) {
			res.setStatus(404);
		}
		return categories;
	}
	
	@GetMapping("books/{bookId}/authors")
	public List<Author> getAuthorsByBook(
			@PathVariable Integer bookId,
			HttpServletResponse res
			) {
		List<Author> authors = bookService.authors(bookId);
		if(authors == null) {
			res.setStatus(404);
		}
		return authors;
	}
	
	
	
	
}
