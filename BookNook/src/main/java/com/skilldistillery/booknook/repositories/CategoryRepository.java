package com.skilldistillery.booknook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.booknook.entities.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer>{

	
	
}
