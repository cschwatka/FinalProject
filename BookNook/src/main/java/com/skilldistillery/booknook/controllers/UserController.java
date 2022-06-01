package com.skilldistillery.booknook.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.entities.User;
import com.skilldistillery.booknook.services.UserService;

@RestController
@CrossOrigin({ "*", "http://localhost:4209" })
@RequestMapping("api")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping("users/{userId}")
	public User getUserById(
	  @PathVariable Integer userId,
	  HttpServletResponse res
	) {
	  User user = userService.getUserById(userId);
	  
	  if (user == null) {
	    res.setStatus(404);
	  }
	  return user;
	}
	
	@GetMapping("users")
	public List<User> getListOfUsers(
			HttpServletResponse res,
			HttpServletRequest req
			) {
		List<User> users = userService.index();
		return users;
	}
	
	@PutMapping("users/{userId}")
	public User update(
			@PathVariable Integer userId,
			@RequestBody User user,
			HttpServletResponse res,
			HttpServletRequest req
			) {
		User newUser = userService.update(userId, user);
		if (newUser == null) {
			res.setStatus(404);
		}
		return newUser;
	}
	
	@DeleteMapping("users/{userId}")
	public User destroy(
			@PathVariable Integer userId,
			HttpServletResponse res
			) {
		User deleteUser = userService.destroy(userId);
		if (deleteUser == null) {
			res.setStatus(404);
		}
		return deleteUser;
	}
	
	@GetMapping("users/{userId}/categories")
	public List<Category> getCategoriesByUser(
			@PathVariable Integer userId,
			HttpServletResponse res
			) {
		List<Category> categories = userService.categories(userId);
		if(categories == null) {
			res.setStatus(404);
		}
		return categories;
	}
	
	@GetMapping("users/{userId}/authors")
	public List<Author> getAuthorsByUser(
			@PathVariable Integer userId,
			HttpServletResponse res
			) {
		List<Author> authors = userService.authors(userId);
		if(authors == null) {
			res.setStatus(404);
		}
		return authors;
	}
	
	@GetMapping("users/{userId}/favoritebooks")
	public List<Book> getFavoriteBooksByUser(
			@PathVariable Integer userId,
			HttpServletResponse res
			) {
		List<Book> books = userService.favoriteBooks(userId);
		if(books == null) {
			res.setStatus(404);
		}
		return books;
	}
	
	@GetMapping("users/{userId}/finishedbooks")
	public List<Book> getFinishedBooksByUser(
			@PathVariable Integer userId,
			HttpServletResponse res
			) {
		List<Book> books = userService.favoriteBooks(userId);
		if(books == null) {
			res.setStatus(404);
		}
		return books;
	}
	
	@GetMapping("users/{userId}/readingbooks")
	public List<Book> getReadingBooksByUser(
			@PathVariable Integer userId,
			HttpServletResponse res
			) {
		List<Book> books = userService.favoriteBooks(userId);
		if(books == null) {
			res.setStatus(404);
		}
		return books;
	}
	
	@GetMapping("users/{userId}/wishlistbooks")
	public List<Book> getWishlistBooksByUser(
			@PathVariable Integer userId,
			HttpServletResponse res
			) {
		List<Book> books = userService.wishlistBooks(userId);
		if(books == null) {
			res.setStatus(404);
		}
		return books;
	}
	
	@GetMapping("users/{userId}/followers")
	public List<User> getfollowersByUser(
			@PathVariable Integer userId,
			HttpServletResponse res
			) {
		List<User> users = userService.followers(userId);
		if(users == null) {
			res.setStatus(404);
		}
		return users;
	}
	
	@GetMapping("users/{userId}/followedUsers")
	public List<User> getfollowedUsersByUser(
			@PathVariable Integer userId,
			HttpServletResponse res
			) {
		List<User> users = userService.followedUsers(userId);
		if(users == null) {
			res.setStatus(404);
		}
		return users;
	}
	
	@PutMapping("users/{userId}/wishlistbooks")
	public Book addBookToUserWishlist(
			@PathVariable Integer userId,
			@RequestBody Book books,
			HttpServletResponse res,
			HttpServletRequest req
			){
		System.out.println("You hit the controller!");
		Book newBooks = userService.addBookToWishlist(userId, books);
		if( newBooks == null) {
			res.setStatus(404);
		}
		return newBooks;
	}
	
	@DeleteMapping("users/{userId}/wishlistbooks/{bookId}")
	public void deleteBookFromUserWishlist(
			@PathVariable Integer userId,
			@PathVariable Integer bookId,
			HttpServletResponse res,
			HttpServletRequest req
			){
		userService.removeBookFromWishlist(userId, bookId);
	}
	
	@PostMapping("users/{userId}/readingbooks")
	public Book addBookToUserReadingBooks(
			@PathVariable Integer userId,
			@RequestBody Book book,
			HttpServletResponse res,
			HttpServletRequest req
			){
		Book books = userService.addBookToReading(userId, book);
		if( books == null) {
			res.setStatus(404);
		}
		return books;
	}
	
	@DeleteMapping("users/{userId}/readingbooks/{bookId}")
	public void deleteBookFromUserReadingBooks(
			@PathVariable Integer userId,
			@PathVariable Integer bookId,
			HttpServletResponse res,
			HttpServletRequest req
			){
		userService.removeBookFromReading(userId, bookId);
	}
	@PostMapping("users/{userId}/finishedbooks")
	public Book addBookToUserFinishedBooks(
			@PathVariable Integer userId,
			@RequestBody Book book,
			HttpServletResponse res,
			HttpServletRequest req
			){
		Book books = userService.addBookToFinished(userId, book);
		if( books == null) {
			res.setStatus(404);
		}
		return books;
	}
	
	@DeleteMapping("users/{userId}/finishedbooks/{bookId}")
	public void deleteBookFromUserFinishedBooks(
			@PathVariable Integer userId,
			@PathVariable Integer bookId,
			HttpServletResponse res,
			HttpServletRequest req
			){
		userService.removeBookFromFinished(userId, bookId);
	}
	
	@PostMapping("users/{userId}/favoritebooks")
	public Book addBookToUserFavorites(
			@PathVariable Integer userId,
			@RequestBody Book book,
			HttpServletResponse res,
			HttpServletRequest req
			){
		Book books = userService.addBookToFavorites(userId, book);
		if( books == null) {
			res.setStatus(404);
		}
		return books;
	}
	
	@DeleteMapping("users/{userId}/favoritebooks/{bookId}")
	public void deleteBookFromUserFavorites(
			@PathVariable Integer userId,
			@PathVariable Integer bookId,
			HttpServletResponse res,
			HttpServletRequest req
			){
		userService.removeBookFromFavorites(userId, bookId);
	}
	
	
	@PostMapping("users/{userId}/userfollow/{userToFollowId}")
	public User addUserToUserUsersFollowing(
			@PathVariable Integer userId,
			@RequestBody User user,
			@PathVariable Integer userToFollowId,
			HttpServletResponse res,
			HttpServletRequest req
			){
		User userDoingTheFollowing = userService.addUserToUsersFollowing(userId, userToFollowId, user);
		if( userDoingTheFollowing == null) {
			res.setStatus(404);
		}
		return userDoingTheFollowing;
	}
	
	@DeleteMapping("users/{userId}/userfollow/{userToFollowId}")
	public void deleteUserFromUserUsersFollowing(
			@PathVariable Integer userId,
			@PathVariable Integer userToFollowId,
			HttpServletResponse res,
			HttpServletRequest req
			){
		userService.deleteUserFromUserUsersFollowing(userId, userToFollowId);
		
	}
	
}
