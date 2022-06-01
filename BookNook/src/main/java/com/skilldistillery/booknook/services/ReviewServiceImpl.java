package com.skilldistillery.booknook.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.booknook.entities.Book;
import com.skilldistillery.booknook.entities.Review;
import com.skilldistillery.booknook.repositories.BookRepository;
import com.skilldistillery.booknook.repositories.ReviewRepository;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewRepository reviewRepo;
	@Autowired
	private BookRepository bookRepo;

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
	public Review create(Review review, int id) {
		Optional<Book> bookOpt = bookRepo.findById(id);
		Book book = null;
		if (bookOpt.isPresent()) {
			book = bookOpt.get();
			review.setBook(book);
		}
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
