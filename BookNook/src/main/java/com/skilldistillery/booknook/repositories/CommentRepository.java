package com.skilldistillery.booknook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.booknook.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer>{
	
	

}
