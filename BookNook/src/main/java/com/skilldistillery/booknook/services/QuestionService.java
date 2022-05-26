package com.skilldistillery.booknook.services;

import java.util.List;

import com.skilldistillery.booknook.entities.Question;

public interface QuestionService {
	
	Question getQuestionById(int questionId);
	
	List<Question> index();
	
	Question create(Question question);
	
	Question update(int questionId, Question question);
	
	Question destroy(int questionId);

}
