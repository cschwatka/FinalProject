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
	
	public Book addBookToWishlist(int userId, Book books);
	
	public void removeBookFromWishlist(int userId, int bookId);
	
	public Book addBookToFavorites(int userId, Book books);
	
	public void removeBookFromFavorites(int userId, int bookId);
	
	public Book addBookToReading(int userId, Book books);
	
	public void removeBookFromReading(int userId, int bookId);
	
	public Book addBookToFinished(int userId, Book books);
	
	public void removeBookFromFinished(int userId, int bookId);
	
	public User addUserToUsersFollowing(int userId, int userToFollowId, User user);
	
	public void deleteUserFromUserUsersFollowing(int userId, int userToFollowId);
}
