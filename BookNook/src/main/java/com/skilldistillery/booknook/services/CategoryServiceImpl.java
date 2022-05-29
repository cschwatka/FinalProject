package com.skilldistillery.booknook.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.repositories.CategoryRepository;

@Service
public class CategoryServiceImpl implements CategoryService {
	
	@Autowired
	private CategoryRepository repo;

	@Override
	public Category getCategoryById(int categoryId) {
		Optional<Category> categoryOpt = repo.findById(categoryId);
		if (categoryOpt.isPresent()) {
			return categoryOpt.get();
		}
		return null;
	}

	@Override
	public List<Category> index() {
		return repo.findAll();
	}

}
