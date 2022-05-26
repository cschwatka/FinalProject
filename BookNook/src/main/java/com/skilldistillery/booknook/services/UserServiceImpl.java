package com.skilldistillery.booknook.services;

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

	

}
