package com.skilldistillery.booknook.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.repositories.BookRepository;

@Service
public class BookServiceImpl implements BookService {

	@Autowired
	private BookRepository bookRepo;
	
	@Override
	public Book getBookById(int bookId) {
		Optional<Book> bookOpt = bookRepo.findById(bookId);
		if (bookOpt.isPresent()) {
			return bookOpt.get();
		}
		return null;
	}

	@Override
	public List<Book> index() {
		return bookRepo.findAll();
	}

	@Override
	public Book update(int bookId, Book book) {
		if(getBookById(bookId) != null) {
			book.setId(bookId);
			return bookRepo.saveAndFlush(book);
		}
		return null;
	}

	@Override
	public Book destroy(int bookId) {
		if(getBookById(bookId) != null) {
			Book book = getBookById(bookId);
			book.setEnabled(false);
			return book;
		}
			return null;
	}

	@Override
	public List<Category> categories(int bookId) {
		return bookRepo.findCategoriesById(bookId);
	}

	@Override
	public List<Author> authors(int bookId) {
		return bookRepo.findAuthorsById(bookId);
	}

}
