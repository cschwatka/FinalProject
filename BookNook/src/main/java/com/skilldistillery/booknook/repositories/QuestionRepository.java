package com.skilldistillery.booknook.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.booknook.entities.Author;
import com.skilldistillery.booknook.entities.Category;
import com.skilldistillery.booknook.entities.Question;

public interface QuestionRepository extends JpaRepository<Question, Integer>{

	
}
