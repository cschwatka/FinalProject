package com.skilldistillery.booknook.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.entities.User;
import com.skilldistillery.booknook.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserRepository userRepo;

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
		if( getUserById(userId) != null) {
			user.setId(userId);
			return userRepo.saveAndFlush(user);
		}
		return null;
	}

	@Override
	public User destroy(int userId) {
		if( getUserById(userId) != null) {
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
	public List<Book> addBookToWishlist(int userId, Book book) {
		List<Book> wishlistBooks = new ArrayList<>();
		wishlistBooks = userRepo.findWishlistBooksById(userId);
		for (Book existingBook : wishlistBooks) {
			if (book.equals(existingBook)) {
				return wishlistBooks;
			}
		}
		wishlistBooks.add(book);			
		return wishlistBooks;
	}

	@Override
	public List<Book> removeBookFromWishlist(int userId, int bookId) {
		List<Book> wishlistBooks = new ArrayList<>();
		wishlistBooks = userRepo.findWishlistBooksById(userId);
		for (Book existingBook : wishlistBooks) {
			if (bookId == existingBook.getId()) {
				wishlistBooks.remove(existingBook);
			}
		}
		return wishlistBooks;
	}

	@Override
	public List<Book> addBookToCurrentlyReading(int userId, Book book) {
		List<Book> readingBooks = new ArrayList<>();
		readingBooks = userRepo.findReadingBooksById(userId);
		for (Book existingBook : readingBooks) {
			if (book.equals(existingBook)) {
				return readingBooks;
			}
		}
		readingBooks.add(book);			
		return readingBooks;
	}

	@Override
	public List<Book> removeBookFromCurrentlyReading(int userId, int bookId) {
		List<Book> readingBooks = new ArrayList<>();
		readingBooks = userRepo.findReadingBooksById(userId);
		for (Book existingBook : readingBooks) {
			if (bookId == existingBook.getId()) {
				readingBooks.remove(existingBook);
			}
		}
		return readingBooks;
	}

	@Override
	public List<Book> addBookToFinishedBooks(int userId, Book book) {
		List<Book> finishedBooks = new ArrayList<>();
		finishedBooks = userRepo.findFinishedBooksById(userId);
		for (Book existingBook : finishedBooks) {
			if (book.equals(existingBook)) {
				return finishedBooks;
			}
		}
		finishedBooks.add(book);			
		return finishedBooks;
	}

	@Override
	public List<Book> removeBookFromFinishedBooks(int userId, int bookId) {
		List<Book> finishedBooks = new ArrayList<>();
		finishedBooks = userRepo.findFinishedBooksById(userId);
		for (Book existingBook : finishedBooks) {
			if (bookId == existingBook.getId()) {
				finishedBooks.remove(existingBook);
			}
		}
		return finishedBooks;
	}

	@Override
	public List<Book> addBookToFavorites(int userId, Book book) {
		List<Book> favorites = new ArrayList<>();
		favorites = userRepo.findFavoriteBooksById(userId);
		for (Book existingBook : favorites) {
			if (book.equals(existingBook)) {
				return favorites;
			}
		}
		favorites.add(book);			
		return favorites;
	}

	@Override
	public List<Book> removeBookFromFavorites(int userId, int bookId) {
		List<Book> favorites = new ArrayList<>();
		favorites = userRepo.findFavoriteBooksById(userId);
		for (Book existingBook : favorites) {
			if (bookId == existingBook.getId()) {
				favorites.remove(existingBook);
			}
		}
		return favorites;
	}

	

}
