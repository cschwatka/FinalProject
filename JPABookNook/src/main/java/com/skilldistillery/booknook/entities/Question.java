package com.skilldistillery.booknook.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Question {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String content;
	
	@Column(name="question_date")
	@CreationTimestamp
	private LocalDateTime questionDate;
	
	private boolean enabled;
	
	@JsonIgnoreProperties({"wishlistUsers","readingUsers", "finishedUsers", "favoriteUsers", "reviews", "authors","categories"})
	@ManyToOne
	@JoinColumn(name="book_id")
	private Book book;
	
	@JsonIgnoreProperties({"usersFollowing","followedUsers", "users", "books","categories","authors",
		"reviews","answers","posts","comments","postVotes","commentVotes","answerVotes", 
		"favoriteBooks", "finishedBooks", "readingBooks","wishlistBooks"})
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@OneToMany(mappedBy="question")
	private List<Answer> answers;

	public Question() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getQuestionDate() {
		return questionDate;
	}

	public void setQuestionDate(LocalDateTime questionDate) {
		this.questionDate = questionDate;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Answer> getAnswers() {
		return answers;
	}

	public void setAnswers(List<Answer> answers) {
		this.answers = answers;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Question other = (Question) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Question [id=" + id + ", content=" + content + ", questionDate=" + questionDate + ", enabled=" + enabled
				+ "]";
	}
	
	
}
