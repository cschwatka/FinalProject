package com.skilldistillery.booknook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.booknook.entities.Post;


public interface PostRepository extends JpaRepository<Post, Integer>{
	

}
