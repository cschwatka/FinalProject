package com.skilldistillery.booknook.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.booknook.services.BookService;

@RestController
@CrossOrigin({"*", "http://localhost"})
@RequestMapping("api")
public class BookController {
	
	@Autowired
	private BookService bookService;

	
	
}
