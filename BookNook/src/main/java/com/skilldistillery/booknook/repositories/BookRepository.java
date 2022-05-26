package com.skilldistillery.booknook.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Category;

public interface BookRepository extends JpaRepository<Book, Integer>{

	public List<Category> findCategoriesByBookId(int bookId);
	
	public List<Author> findAuthorsByBookId(int bookId);
	
}
