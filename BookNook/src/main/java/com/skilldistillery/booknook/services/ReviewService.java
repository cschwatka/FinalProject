package com.skilldistillery.booknook.services;

import java.util.List;

import com.skilldistillery.booknook.entities.Review;

public interface ReviewService {
	
	Review getReviewById(int reviewId);
	
	List<Review> index();
	
	Review create(Review review);
	
	Review update(int reviewId, Review review);
	
	Review destroy(int reviewId);

}
