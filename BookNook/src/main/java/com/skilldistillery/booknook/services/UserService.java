package com.skilldistillery.booknook.services;

import java.util.List;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.entities.User;

public interface UserService {
	
	public User getUserById(int userId);
	
	public List<User> index();
	
	public User update(int userId, User user);
	
	public User destroy(int userId);
	
	public List<Category> categories(int userId);
	
	public List<Author> authors(int userId);
	
	public List<Book> favoriteBooks(int userId);
	
	public List<Book> finishedBooks(int userId);
	
	public List<Book> readingBooks(int userId);
	
	public List<Book> wishlistBooks(int userId);
	
	public List<User> followers(int userId);
	
	public List<User> followedUsers(int userId);
	
	public List<Book> addBookToWishlist(int userId, Book book);
	
	public List<Book> removeBookFromWishlist(int userId, int bookId);
	
	public List<Book> addBookToCurrentlyReading(int userId, Book book);
	
	public List<Book> removeBookFromCurrentlyReading(int userId, int bookId);
	
	public List<Book> addBookToFinishedBooks(int userId, Book book);
	
	public List<Book> removeBookFromFinishedBooks(int userId, int bookId);
	
	public List<Book> addBookToFavorites(int userId, Book book);
	
	public List<Book> removeBookFromFavorites(int userId, int bookId);

}
