package com.skilldistillery.booknook.services;

import java.util.List;

import com.skilldistillery.booknook.entities.Post;

public interface PostService {
	
	public Post getPostById(int bookId);
	
	public List<Post> index();
	
	public Post update(int postId, Post post);
	
	public Post destroy(int postId);

}
