package com.skilldistillery.booknook.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.booknook.entities.Language;
import com.skilldistillery.booknook.services.LanguageService;

@RestController
@CrossOrigin({ "*", "http://localhost:4209" })
@RequestMapping("api")
public class LanguageController {

	@Autowired
	private LanguageService languageService;
	
	@GetMapping("languages")
	public List<Language> getListOfLanguages(
			HttpServletResponse res,
			HttpServletRequest req
			) {
		List<Language> languages = languageService.index();
		return languages;
	}
	
	
}
