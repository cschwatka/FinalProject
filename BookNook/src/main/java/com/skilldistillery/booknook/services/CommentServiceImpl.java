package com.skilldistillery.booknook.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.booknook.entities.Comment;
import com.skilldistillery.booknook.repositories.CommentRepository;

public class CommentServiceImpl implements CommentService {
	
	@Autowired
	private CommentRepository commentRepo;

	@Override
	public Comment getCommentById(int commentId) {
		Optional<Comment> commentOpt = commentRepo.findById(commentId);
		if (commentOpt.isPresent()) {
			return commentOpt.get();
		}
		return null;
	}

	@Override
	public List<Comment> index() {
		return commentRepo.findAll();
	}

	@Override
	public Comment update(int commentId, Comment comment) {
		if(getCommentById(commentId) != null) {
			comment.setId(commentId);
			return commentRepo.saveAndFlush(comment);
		}
		return null;
	}

	@Override
	public Comment destroy(int commentId) {
		if(getCommentById(commentId) != null) {
			Comment comment = getCommentById(commentId);
			comment.setEnabled(false);
			return comment;
		}
			return null;
	}

	

}
