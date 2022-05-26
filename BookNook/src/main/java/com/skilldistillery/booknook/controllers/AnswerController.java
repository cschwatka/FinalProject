package com.skilldistillery.booknook.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.booknook.entities.Answer;
import com.skilldistillery.booknook.services.AnswerService;

@RestController
@CrossOrigin({"*", "http://localhost:4209"})
public class AnswerController {

	@Autowired
	private AnswerService answerService;
	
	@GetMapping("answers/{answerId}")
	public Answer getAnswerById(
	  @PathVariable Integer answerId,
	  HttpServletResponse res
	) {
	  Answer answer = answerService.getAnswerById(answerId);
	  
	  if (answer == null) {
	    res.setStatus(404);
	  }
	  return answer;
	}
	
	@GetMapping("answers")
	public List<Answer> getListOfAnswers(
			HttpServletResponse res,
			HttpServletRequest req
			) {
		List<Answer> answers = answerService.index();
		return answers;
	}
	
	@PostMapping("answers")
	public Answer create(@RequestBody Answer answer, HttpServletResponse res,
			HttpServletRequest req) {
		
		Answer newAnswer = answerService.create(answer);
		if (newAnswer == null) {
			res.setStatus(404);
		}
		return newAnswer;
		
	}
	
	@PutMapping("answers/{answerId}")
	public Answer update(
			@PathVariable Integer answerId,
			@RequestBody Answer answer,
			HttpServletResponse res,
			HttpServletRequest req
			) {
		Answer newAnswer = answerService.update(answerId, answer);
		if (newAnswer == null) {
			res.setStatus(404);
		}
		return newAnswer;
	}
	
	@DeleteMapping("answers/{answerId}")
	public Answer destroy(
			@PathVariable Integer answerId,
			HttpServletResponse res
			) {
		Answer deleteAnswer = answerService.destroy(answerId);
		if (deleteAnswer == null) {
			res.setStatus(404);
		}
		return deleteAnswer;
	}
	
}
