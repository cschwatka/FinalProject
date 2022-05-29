package com.skilldistillery.booknook.services;

import java.util.List;

import com.skilldistillery.booknook.entities.Category;

public interface CategoryService {
	
	Category getCategoryById(int questionId);
	
	List<Category> index();
	
}
