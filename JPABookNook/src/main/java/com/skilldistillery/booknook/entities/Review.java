package com.skilldistillery.booknook.entities;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Review {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="book_id")
	private Book book;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	private String content;
	
	private Integer rating;
	
	private boolean enabled;
	
	private String title;
	
	@Column(name="review_date")
	@CreationTimestamp
	private LocalDateTime reviewDate;


	
	
}
