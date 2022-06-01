package com.skilldistillery.booknook.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.entities.User;
import com.skilldistillery.booknook.repositories.BookRepository;
import com.skilldistillery.booknook.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private BookRepository bookRepo;

	@Override
	public User getUserById(int userId) {
		Optional<User> userOpt = userRepo.findById(userId);
		if (userOpt.isPresent()) {
			return userOpt.get();
		}
		return null;
	}

	@Override
	public List<User> index() {
		return userRepo.findAll();
	}

	@Override
	public User update(int userId, User user) {
		User managedUser = getUserById(userId);
		user.setUsersFollowing(managedUser.getUsersFollowing()); // PATCH for property removal in frontend service

		if (getUserById(userId) != null) {
			user.setId(userId);
			return userRepo.saveAndFlush(user);
		}
		return null;
	}

	@Override
	public User destroy(int userId) {
		if (getUserById(userId) != null) {
			User user = getUserById(userId);
			user.setEnabled(false);
			return user;
		}
		return null;
	}

	@Override
	public List<Category> categories(int userId) {
		return userRepo.findCategoriesById(userId);
	}

	@Override
	public List<Author> authors(int userId) {
		return userRepo.findAuthorsById(userId);
	}

	@Override
	public List<Book> favoriteBooks(int userId) {
		return userRepo.findFavoriteBooksById(userId);
	}

	@Override
	public List<Book> finishedBooks(int userId) {
		return userRepo.findFinishedBooksById(userId);
	}

	@Override
	public List<Book> readingBooks(int userId) {
		return userRepo.findReadingBooksById(userId);
	}

	@Override
	public List<Book> wishlistBooks(int userId) {
		return userRepo.findWishlistBooksById(userId);
	}

	@Override
	public List<User> followers(int userId) {
		return userRepo.findUsersFollowingById(userId);
	}

	@Override
	public List<User> followedUsers(int userId) {
		return userRepo.findFollowedUsersById(userId);
	}

	@Override
	public Book addBookToWishlist(int userId, Book book) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		Optional<Book> bookOpt = bookRepo.findById(book.getId());
		Book managedBook = null;
		if (bookOpt.isPresent()) {
			managedBook = bookOpt.get();
		}

		managedBook.addUserToWishlist(user);
		bookRepo.saveAndFlush(managedBook);
		return managedBook;
	}

	@Override
	public void removeBookFromWishlist(int userId, int bookId) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		Optional<Book> bookOpt = bookRepo.findById(bookId);
		Book managedBook = null;
		if (bookOpt.isPresent()) {
			managedBook = bookOpt.get();
		}
		managedBook.removeUserFromWishlist(user);
		bookRepo.saveAndFlush(managedBook);
	}

	@Override
	public Book addBookToFavorites(int userId, Book book) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		Optional<Book> bookOpt = bookRepo.findById(book.getId());
		Book managedBook = null;
		if (bookOpt.isPresent()) {
			managedBook = bookOpt.get();
		}

		managedBook.addUserToFavorites(user);
		bookRepo.saveAndFlush(managedBook);
		return managedBook;
	}

	@Override
	public void removeBookFromFavorites(int userId, int bookId) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		Optional<Book> bookOpt = bookRepo.findById(bookId);
		Book managedBook = null;
		if (bookOpt.isPresent()) {
			managedBook = bookOpt.get();
		}
		managedBook.removeUserFromFavorites(user);
		bookRepo.saveAndFlush(managedBook);
	}

	@Override
	public Book addBookToReading(int userId, Book book) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		Optional<Book> bookOpt = bookRepo.findById(book.getId());
		Book managedBook = null;
		if (bookOpt.isPresent()) {
			managedBook = bookOpt.get();
		}

		managedBook.addUserToReading(user);
		bookRepo.saveAndFlush(managedBook);
		return managedBook;
	}

	@Override
	public void removeBookFromReading(int userId, int bookId) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		Optional<Book> bookOpt = bookRepo.findById(bookId);
		Book managedBook = null;
		if (bookOpt.isPresent()) {
			managedBook = bookOpt.get();
		}
		managedBook.removeUserFromReading(user);
		bookRepo.saveAndFlush(managedBook);
	}

	@Override
	public Book addBookToFinished(int userId, Book book) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		Optional<Book> bookOpt = bookRepo.findById(book.getId());
		Book managedBook = null;
		if (bookOpt.isPresent()) {
			managedBook = bookOpt.get();
		}

		managedBook.addUserToFinished(user);
		bookRepo.saveAndFlush(managedBook);
		return managedBook;
	}

	@Override
	public void removeBookFromFinished(int userId, int bookId) {
		Optional<User> userOpt = userRepo.findById(userId);
		User user = null;
		if (userOpt.isPresent()) {
			user = userOpt.get();
		}
		Optional<Book> bookOpt = bookRepo.findById(bookId);
		Book managedBook = null;
		if (bookOpt.isPresent()) {
			managedBook = bookOpt.get();
		}
		managedBook.removeUserFromFinished(user);
		bookRepo.saveAndFlush(managedBook);
	}

	@Override
//	public User addUserToUsersFollowing(int userId, int userToFollowId) {
	public User addUserToUsersFollowing(int userId, int userToFollowId, User user) {

		Optional<User> userOptFollow = userRepo.findById(userToFollowId);
		User userToFollow = null;
		if (userOptFollow.isPresent()) {
			userToFollow = userOptFollow.get();
		}

		Optional<User> userOpt = userRepo.findById(userId);
		User userDoingTheFollowing = null;
		if (userOpt.isPresent()) {
			userDoingTheFollowing = userOpt.get();
		}

		userDoingTheFollowing.addUserToUsersFollowing(userToFollow);

		userRepo.saveAndFlush(userDoingTheFollowing);

		return userDoingTheFollowing;
	}

	@Override
	public void deleteUserFromUserUsersFollowing(int userId, int userToFollowId) {
		Optional<User> userOptFollow = userRepo.findById(userToFollowId);
		User userToFollow = null;
		if (userOptFollow.isPresent()) {
			userToFollow = userOptFollow.get();
		}
		
		Optional<User> userOpt = userRepo.findById(userId);
		User userDoingTheFollowing = null;
		if (userOpt.isPresent()) {
			userDoingTheFollowing = userOpt.get();
		}
		
		userDoingTheFollowing.removeUserFromUsersFollowing(userToFollow);
		userRepo.saveAndFlush(userDoingTheFollowing);
		
	}

}
