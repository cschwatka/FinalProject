package com.skilldistillery.booknook.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.booknook.entities.Comment;
import com.skilldistillery.booknook.entities.Post;
import com.skilldistillery.booknook.entities.User;
import com.skilldistillery.booknook.repositories.CommentRepository;
import com.skilldistillery.booknook.repositories.PostRepository;
import com.skilldistillery.booknook.repositories.UserRepository;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	private CommentRepository commentRepo;
	
	@Autowired
	private PostRepository postRepo;
	
	@Autowired
	private UserRepository userRepo;

	@Override
	public Comment getCommentById(int commentId) {
		Optional<Comment> commentOpt = commentRepo.findById(commentId);
		if (commentOpt.isPresent()) {
			return commentOpt.get();
		}
		return null;
	}
	
	@Override
	public User getUserById(int userId) {
		Optional<User> userOpt = userRepo.findById(userId);
		if (userOpt.isPresent()) {
			return userOpt.get();
		}
		return null;
	}


	@Override
	public List<Comment> index() {
		return commentRepo.findAll();
	}
	
	@Override
	public Post getPostById(int postId) {
		Optional<Post> postOpt = postRepo.findById(postId);
		if (postOpt.isPresent()) {
			return postOpt.get();
		}
		return null;
	}
	
	@Override
	public Comment post(Comment comment, int postId, int commentId, int userId) {
		comment.setPost(getPostById(postId));
		comment.setComment(getCommentById(commentId));
		comment.setUser(getUserById(userId));
		return commentRepo.saveAndFlush(comment);
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
