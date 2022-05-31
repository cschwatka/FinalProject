package com.skilldistillery.booknook.services;

import java.util.List;

import com.skilldistillery.booknook.entities.Comment;
import com.skilldistillery.booknook.entities.Post;
import com.skilldistillery.booknook.entities.User;

public interface CommentService {
	
public Comment getCommentById(int commentId);
	
	public List<Comment> index();
	
	public Comment update(int commentId, Comment comment);
	
	public Comment destroy(int commentId);
	
	public Comment post(Comment comment, int postId, int commentId, int userId);
	
	public Post getPostById(int postId);
	
	public User getUserById(int userId);
	

}
