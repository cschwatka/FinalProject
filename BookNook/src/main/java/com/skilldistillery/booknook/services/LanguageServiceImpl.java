package com.skilldistillery.booknook.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.booknook.entities.Language;
import com.skilldistillery.booknook.repositories.LanguageRepository;

@Service
public class LanguageServiceImpl implements LanguageService{

	@Autowired
	private LanguageRepository languageRepo;
	
	@Override
	public List<Language> index() {
		return languageRepo.findAll();
	}
}
