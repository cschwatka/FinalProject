package com.skilldistillery.booknook.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Question;
import com.skilldistillery.booknook.repositories.QuestionRepository;

public class QuestionServiceImpl implements QuestionService {
	
	@Autowired
	private QuestionRepository questionRepo;

	@Override
	public Question getQuestionById(int questionId) {
		Optional<Question> questionOpt = questionRepo.findById(questionId);
		if (questionOpt.isPresent()) {
			return questionOpt.get();
		}
		return null;
	}

	@Override
	public List<Question> index() {
		return questionRepo.findAll();
	}

	@Override
	public Question create(Question question) {
		return questionRepo.saveAndFlush(question);
	}

	@Override
	public Question update(int questionId, Question question) {
		if(getQuestionById(questionId) != null) {
			question.setId(questionId);
			return questionRepo.saveAndFlush(question);
		}
		return null;
	}

	@Override
	public Question destroy(int questionId) {
		if(getQuestionById(questionId) != null) {
			Question question = getQuestionById(questionId);
			question.setEnabled(false);
			return question;
		}
			return null;
	}
	
}
