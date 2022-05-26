package com.skilldistillery.booknook.services;

import java.util.List;

import com.skilldistillery.booknook.entities.Answer;

public interface AnswerService {
	
	Answer getAnswerById(int questionId);
	
	List<Answer> index();
	
	Answer create(Answer question);
	
	Answer update(int questionId, Answer question);
	
	Answer destroy(int questionId);

}
