package com.skilldistillery.booknook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.booknook.entities.Review;

public interface ReviewRepository extends JpaRepository<Review, Integer>{

	
	
}
