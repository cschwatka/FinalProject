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

import com.skilldistillery.booknook.entities.Post;
import com.skilldistillery.booknook.services.PostService;

@RestController
@CrossOrigin({ "*", "http://localhost:4209" })
@RequestMapping("api")
public class PostController {
	
	@Autowired
	private PostService postService;
	
	@GetMapping("posts/{postId}")
	public Post getPostById(
	  @PathVariable Integer postId,
	  HttpServletResponse res
	) {
		Post post = postService.getPostById(postId);
	  
	  if (post == null) {
	    res.setStatus(404);
	  }
	  return post;
	}
	
	@GetMapping("posts")
	public List<Post> getListOfPosts(
			HttpServletResponse res,
			HttpServletRequest req
			) {
		List<Post> posts = postService.index();
		return posts;
	}
	
	@PostMapping("posts")
	public Post post(
			@RequestBody Post post,
			HttpServletResponse res,
			HttpServletRequest req
			) {
		Post newPost = postService.create(post);
		if (newPost == null) {
			res.setStatus(404);
		}
		return newPost;
	}
	
	@PutMapping("posts/{postId}")
	public Post update(
			@PathVariable Integer postId,
			@RequestBody Post post,
			HttpServletResponse res,
			HttpServletRequest req
			) {
		Post newPost = postService.update(postId, post);
		if (newPost == null) {
			res.setStatus(404);
		}
		return newPost;
	}
	
	@DeleteMapping("posts/{postId}")
	public Post destroy(
			@PathVariable Integer postId,
			HttpServletResponse res
			) {
		Post deletePost = postService.destroy(postId);
		if (deletePost == null) {
			res.setStatus(404);
		}
		return deletePost;
	}
	

}
