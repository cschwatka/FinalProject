package com.skilldistillery.booknook.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.booknook.entities.Post;
import com.skilldistillery.booknook.repositories.PostRepository;

@Service
public class PostServiceImpl implements PostService {
	
	@Autowired
	private PostRepository postRepo;

	@Override
	public Post getPostById(int bookId) {
		Optional<Post> postOpt = postRepo.findById(bookId);
		if (postOpt.isPresent()) {
			return postOpt.get();
		}
		return null;
	}
	
	@Override
	public List<Post> index() {
		return postRepo.findAll();
	}
	
	@Override
	public Post update(int postId, Post post) {
		if(getPostById(postId) != null) {
			post.setId(postId);
			return postRepo.saveAndFlush(post);
		}
		return null;
	}

	@Override
	public Post destroy(int postId) {
		Optional<Post> postOpt = postRepo.findById(postId);
		Post post = null;
		if (postOpt.isPresent()) {
			post = postOpt.get();
			post.setEnabled(false);
			postRepo.saveAndFlush(post);
		}
			return post;
	}

	@Override
	public Post create(Post post) {
		return postRepo.saveAndFlush(post);
	}
	

}
