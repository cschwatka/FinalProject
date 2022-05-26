package com.skilldistillery.booknook.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	
	public User findByUsername(String username);
	
	public List<Category> findCategoriesByUserId(int userId);
	
	public List<Author> findAuthorsByUserId(int userId);
	
	public List<Book> findFavoriteBooksByUserId(int userId);
	
	public List<Book> findFinishedBooksByUserId(int userId);
	
	public List<Book> findReadingBooksByUserId(int userId);
	
	public List<Book> findWishlistBooksByUserId(int userId);
	
	public List<User> findUsersFollowingByUserId(int userId);
	
	public List<User> findFollowedUsersByUserId(int userId);

}
