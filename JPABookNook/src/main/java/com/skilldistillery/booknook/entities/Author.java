package com.skilldistillery.booknook.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@Entity
public class Author {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name ="full_name")
	private String fullName;
	
	@ManyToMany
	@JoinTable(name = "author_to_book")
	private List<Book> books;
	
	@ManyToMany
	@JoinTable(name = "favorite_authors")
	private List<User> users;
	
}
