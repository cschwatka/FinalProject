package com.skilldistillery.booknook.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	
	public User findByUsername(String username);
	
	public List<Category> findCategoriesById(int userId);
	
	public List<Author> findAuthorsById(int userId);
	
	public List<Book> findFavoriteBooksById(int userId);
	
	public List<Book> findFinishedBooksById(int userId);
	
	public List<Book> findReadingBooksById(int userId);
	
	public List<Book> findWishlistBooksById(int userId);
	
	public List<User> findUsersFollowingById(int userId);
	
	public List<User> findFollowedUsersById(int userId);

}
