package com.skilldistillery.booknook.entities;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Book {
	

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@ManyToOne
	@JoinColumn(name="language_id")
	private Language language;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	private String title; 
	
	private String description;
	
	private boolean enabled;
	
	@Column(name="isbn_10")
	private String isbn10;
	
	@Column(name="page_count")
	private Integer pageCount;
	
	@Column(name="img_url")
	private String imgUrl;
	
	@Column(name="publish_date")
	private LocalDate publishDate;
	
	@Column(name="isbn_13")
	private String isbn13;
	
	@Column(name="date_added")
	@CreationTimestamp
	private LocalDate dateAdded;
	
	@Column(name="last_updated")
	@UpdateTimestamp
	private LocalDateTime lastUpdated;
	
	@JsonIgnoreProperties({"users", "books"})
	@ManyToMany(mappedBy = "books")
	private List<Category> categories;
	
	@JsonIgnoreProperties({"users", "books"})
	@ManyToMany(mappedBy = "books")
	private List<Author> authors;
	
	@JsonIgnore
	@OneToMany(mappedBy = "book")
	private List<Review> reviews;
	
	@JsonIgnoreProperties({"usersFollowing","followedUsers", "users", "books","categories","authors",
		"reviews","answers","posts","comments","postVotes","commentVotes","answerVotes", 
		"favoriteBooks", "finishedBooks", "readingBooks","wishlistBooks"})
	@ManyToMany
	@JoinTable(
			name = "favorite_book",
			joinColumns = @JoinColumn(name = "user_id"),
			inverseJoinColumns = @JoinColumn(name = "book_id")
	)
	private List<User> favoriteUsers;
	
	@JsonIgnoreProperties({"usersFollowing","followedUsers", "users", "books","categories","authors",
		"reviews","answers","posts","comments","postVotes","commentVotes","answerVotes", 
		"favoriteBooks", "finishedBooks", "readingBooks","wishlistBooks"})
	@ManyToMany
	@JoinTable(
			name = "finished",
			joinColumns = @JoinColumn(name = "user_id"),
			inverseJoinColumns = @JoinColumn(name = "book_id")
	)
	private List<User> finishedUsers;
	
	@JsonIgnoreProperties({"usersFollowing","followedUsers", "users", "books","categories","authors",
		"reviews","answers","posts","comments","postVotes","commentVotes","answerVotes", 
		"favoriteBooks", "finishedBooks", "readingBooks","wishlistBooks"})
	@ManyToMany
	@JoinTable(
			name = "currently_reading",
			joinColumns = @JoinColumn(name = "user_id"),
			inverseJoinColumns = @JoinColumn(name = "book_id")
	)
	private List<User> readingUsers;
	
	@JsonIgnoreProperties({"usersFollowing","followedUsers", "users", "books","categories","authors",
		"reviews","answers","posts","comments","postVotes","commentVotes","answerVotes", 
		"favoriteBooks", "finishedBooks", "readingBooks","wishlistBooks"})
	@ManyToMany
	@JoinTable(
			name = "wishlist",
			joinColumns = @JoinColumn(name = "user_id"),
			inverseJoinColumns = @JoinColumn(name = "book_id")
	)
	private List<User> wishlistUsers;

	

	public Book() {
		super();
	}


	
	
	
	public int getId() {
		return id;
	}





	public void setId(int id) {
		this.id = id;
	}











	public Language getLanguage() {
		return language;
	}





	public void setLanguage(Language language) {
		this.language = language;
	}





	public User getUser() {
		return user;
	}





	public void setUser(User user) {
		this.user = user;
	}





	public String getTitle() {
		return title;
	}





	public void setTitle(String title) {
		this.title = title;
	}





	public String getDescription() {
		return description;
	}





	public void setDescription(String description) {
		this.description = description;
	}





	public String getIsbn10() {
		return isbn10;
	}





	public void setIsbn10(String isbn10) {
		this.isbn10 = isbn10;
	}





	public Integer getPageCount() {
		return pageCount;
	}





	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}





	public String getImgUrl() {
		return imgUrl;
	}





	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}





	public LocalDate getPublishDate() {
		return publishDate;
	}





	public void setPublishDate(LocalDate publishDate) {
		this.publishDate = publishDate;
	}





	public String getIsbn13() {
		return isbn13;
	}





	public void setIsbn13(String isbn13) {
		this.isbn13 = isbn13;
	}





	public LocalDate getDateAdded() {
		return dateAdded;
	}





	public void setDateAdded(LocalDate dateAdded) {
		this.dateAdded = dateAdded;
	}





	public LocalDateTime getLastUpdated() {
		return lastUpdated;
	}





	public void setLastUpdated(LocalDateTime lastUpdated) {
		this.lastUpdated = lastUpdated;
	}





	public List<Category> getCategories() {
		return categories;
	}





	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}





	public List<Author> getAuthors() {
		return authors;
	}





	public void setAuthors(List<Author> authors) {
		this.authors = authors;
	}





	public List<Review> getReviews() {
		return reviews;
	}





	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}





	public List<User> getFavoriteUsers() {
		return favoriteUsers;
	}





	public void setFavoriteUsers(List<User> favoriteUsers) {
		this.favoriteUsers = favoriteUsers;
	}





	public List<User> getFinishedUsers() {
		return finishedUsers;
	}





	public void setFinishedUsers(List<User> finishedUsers) {
		this.finishedUsers = finishedUsers;
	}





	public List<User> getReadingUsers() {
		return readingUsers;
	}





	public void setReadingUsers(List<User> readingUsers) {
		this.readingUsers = readingUsers;
	}





	public List<User> getWishlistUsers() {
		return wishlistUsers;
	}





	public void setWishlistUsers(List<User> wishlistUsers) {
		this.wishlistUsers = wishlistUsers;
	}





	public boolean isEnabled() {
		return enabled;
	}





	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
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
		Book other = (Book) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Book [id=" + id + ", title=" + title + ", description=" + description + ", isbn10=" + isbn10
				+ ", pageCount=" + pageCount + ", imgUrl=" + imgUrl + ", publishDate=" + publishDate + ", isbn13="
				+ isbn13 + ", dateAdded=" + dateAdded + ", lastUpdated=" + lastUpdated + "]";
	}

	
	
	
	
	
}
