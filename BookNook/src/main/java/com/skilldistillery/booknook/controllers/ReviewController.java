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
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.booknook.entities.Review;
import com.skilldistillery.booknook.services.ReviewService;

@RestController
@CrossOrigin({"*", "http://localhost:4209"})
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("reviews/{reviewId}")
	public Review getReviewById(
	  @PathVariable Integer reviewId,
	  HttpServletResponse res
	) {
	  Review review = reviewService.getReviewById(reviewId);
	  
	  if (review == null) {
	    res.setStatus(404);
	  }
	  return review;
	}
	
	@GetMapping("reviews")
	public List<Review> getListOfReviews(
			HttpServletResponse res,
			HttpServletRequest req
			) {
		List<Review> reviews = reviewService.index();
		return reviews;
	}
	
	@PostMapping("reviews")
	public Review create(@RequestBody Review review, HttpServletResponse res,
			HttpServletRequest req) {
		
		Review newReview = reviewService.create(review);
		if (newReview == null) {
			res.setStatus(404);
		}
		return newReview;
		
	}
	
	@PutMapping("reviews/{reviewId}")
	public Review update(
			@PathVariable Integer reviewId,
			@RequestBody Review review,
			HttpServletResponse res,
			HttpServletRequest req
			) {
		Review newReview = reviewService.update(reviewId, review);
		if (newReview == null) {
			res.setStatus(404);
		}
		return newReview;
	}
	
	@DeleteMapping("reviews/{reviewId}")
	public Review destroy(
			@PathVariable Integer reviewId,
			HttpServletResponse res
			) {
		Review deleteReview = reviewService.destroy(reviewId);
		if (deleteReview == null) {
			res.setStatus(404);
		}
		return deleteReview;
	}
	
}
