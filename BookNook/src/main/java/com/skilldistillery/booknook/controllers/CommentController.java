package com.skilldistillery.booknook.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.booknook.entities.Comment;
import com.skilldistillery.booknook.services.CommentService;

@RestController
@CrossOrigin({ "*", "http://localhost:4209" })
@RequestMapping("api")
public class CommentController {
	
	private CommentService commentService;
	
	@GetMapping("comments/{commentId}")
	public Comment getBookById(
	  @PathVariable Integer commentId,
	  HttpServletResponse res
	) {
	  Comment comment = commentService.getCommentById(commentId);
	  
	  if (comment == null) {
	    res.setStatus(404);
	  }
	  return comment;
	}
	
	@GetMapping("comments")
	public List<Comment> getListOfComments(
			HttpServletResponse res,
			HttpServletRequest req
			) {
		List<Comment> comments = commentService.index();
		return comments;
	}
	
	@PutMapping("comments/{commentId}")
	public Comment update(
			@PathVariable Integer commentId,
			@RequestBody Comment comment,
			HttpServletResponse res,
			HttpServletRequest req
			) {
		Comment newComment = commentService.update(commentId, comment);
		if (newComment == null) {
			res.setStatus(404);
		}
		return newComment;
	}
	
	@DeleteMapping("comments/{commentId}")
	public Comment destroy(
			@PathVariable Integer commentId,
			HttpServletResponse res
			) {
		Comment deleteComment = commentService.destroy(commentId);
		if (deleteComment == null) {
			res.setStatus(404);
		}
		return deleteComment;
	}
	
	

}
