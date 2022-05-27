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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.booknook.entities.Question;
import com.skilldistillery.booknook.services.QuestionService;

@RestController
@CrossOrigin({"*", "http://localhost:4209"})
@RequestMapping("api")
public class QuestionController {

	@Autowired
	private QuestionService questionService;
	
	@GetMapping("questions/{questionId}")
	public Question getQuestionById(
	  @PathVariable Integer questionId,
	  HttpServletResponse res
	) {
	  Question question = questionService.getQuestionById(questionId);
	  
	  if (question == null) {
	    res.setStatus(404);
	  }
	  return question;
	}
	
	@GetMapping("questions")
	public List<Question> getListOfQuestions(
			HttpServletResponse res,
			HttpServletRequest req
			) {
		List<Question> questions = questionService.index();
		return questions;
	}
	
	@PostMapping("questions")
	public Question create(@RequestBody Question question, HttpServletResponse res,
			HttpServletRequest req) {
		
		Question newQuestion = questionService.create(question);
		if (newQuestion == null) {
			res.setStatus(404);
		}
		return newQuestion;
		
	}
	
	@PutMapping("questions/{questionId}")
	public Question update(
			@PathVariable Integer questionId,
			@RequestBody Question question,
			HttpServletResponse res,
			HttpServletRequest req
			) {
		Question newQuestion = questionService.update(questionId, question);
		if (newQuestion == null) {
			res.setStatus(404);
		}
		return newQuestion;
	}
	
	@DeleteMapping("questions/{questionId}")
	public Question destroy(
			@PathVariable Integer questionId,
			HttpServletResponse res
			) {
		Question deleteQuestion = questionService.destroy(questionId);
		if (deleteQuestion == null) {
			res.setStatus(404);
		}
		return deleteQuestion;
	}
	
}
