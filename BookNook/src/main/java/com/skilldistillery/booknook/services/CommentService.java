package com.skilldistillery.booknook.services;

import java.util.List;

import com.skilldistillery.booknook.entities.Comment;

public interface CommentService {
	
public Comment getCommentById(int commentId);
	
	public List<Comment> index();
	
	public Comment update(int commentId, Comment comment);
	
	public Comment destroy(int commentId);
	
	
	

}
