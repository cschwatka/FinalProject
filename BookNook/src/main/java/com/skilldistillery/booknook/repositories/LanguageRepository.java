package com.skilldistillery.booknook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.booknook.entities.Language;

public interface LanguageRepository extends JpaRepository<Language, Integer>{

}
