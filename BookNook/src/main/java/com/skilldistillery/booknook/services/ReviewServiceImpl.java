package com.skilldistillery.booknook.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import com.skilldistillery.booknook.entities.Review;
import com.skilldistillery.booknook.entities.Review;
import com.skilldistillery.booknook.repositories.ReviewRepository;

public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewRepository reviewRepo;

	@Override
	public Review getReviewById(int reviewId) {
		Optional<Review> reviewOpt = reviewRepo.findById(reviewId);
		if (reviewOpt.isPresent()) {
			return reviewOpt.get();
		}
		return null;
	}

	@Override
	public List<Review> index() {
		return reviewRepo.findAll();
	}

	@Override
	public Review create(Review review) {
		return reviewRepo.saveAndFlush(review);
	}

	@Override
	public Review update(int reviewId, Review review) {
		if(getReviewById(reviewId) != null) {
			review.setId(reviewId);
			return reviewRepo.saveAndFlush(review);
		}
		return null;
	}

	@Override
	public Review destroy(int reviewId) {
		if(getReviewById(reviewId) != null) {
			Review review = getReviewById(reviewId);
			review.setEnabled(false);
			return review;
		}
			return null;
	}

}
