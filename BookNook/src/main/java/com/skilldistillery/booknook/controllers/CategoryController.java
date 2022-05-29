package com.skilldistillery.booknook.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.services.CategoryService;

@RestController
@CrossOrigin({"*", "http://localhost:4209"})
@RequestMapping("api")
public class CategoryController {

	@Autowired
	private CategoryService categoryService;
	
	@GetMapping("categories/{categoryId}")
	public Category getCategoryById(
	  @PathVariable Integer categoryId,
	  HttpServletResponse res
	) {
	  Category category = categoryService.getCategoryById(categoryId);
	  
	  if (category == null) {
	    res.setStatus(404);
	  }
	  return category;
	}
	
	@GetMapping("categories")
	public List<Category> getListOfCategorys(
			HttpServletResponse res,
			HttpServletRequest req
			) {
		List<Category> categories = categoryService.index();
		return categories;
	}
	
}
