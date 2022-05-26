package com.skilldistillery.booknook.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.booknook.entities.Answer;
import com.skilldistillery.booknook.repositories.AnswerRepository;

@Service
public class AnswerServiceImpl implements AnswerService {
	
	@Autowired
	private AnswerRepository answerRepo;

	@Override
	public Answer getAnswerById(int answerId) {
		Optional<Answer> answerOpt = answerRepo.findById(answerId);
		if (answerOpt.isPresent()) {
			return answerOpt.get();
		}
		return null;
	}

	@Override
	public List<Answer> index() {
		return answerRepo.findAll();
	}

	@Override
	public Answer create(Answer answer) {
		return answerRepo.saveAndFlush(answer);
	}

	@Override
	public Answer update(int answerId, Answer answer) {
		if(getAnswerById(answerId) != null) {
			answer.setId(answerId);
			return answerRepo.saveAndFlush(answer);
		}
		return null;
	}

	@Override
	public Answer destroy(int answerId) {
		if(getAnswerById(answerId) != null) {
			Answer answer = getAnswerById(answerId);
			answer.setEnabled(false);
			return answer;
		}
		return null;
	}

}
