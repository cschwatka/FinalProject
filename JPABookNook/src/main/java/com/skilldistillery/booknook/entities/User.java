package com.skilldistillery.booknook.entities;

import java.time.LocalDate;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;
	
	private String password;
	
	private boolean enabled;
	
	private String role;
	
	private String email;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	@Column(name="img_url")
	private String imgUrl;
	
	private String biography;
	
	@Column(name="create_date")
	@CreationTimestamp
	private LocalDate createDate;
	
	@OneToMany(mappedBy = "user")
	private List<Book> books;
	
	@ManyToMany(mappedBy = "users")
	private List<Category> categories;
	
	@ManyToMany(mappedBy = "users")
	private List<Author> authors;
	
	@OneToMany(mappedBy = "user")
	private List<Review> reviews;
	
	@OneToMany(mappedBy = "user")
	private List<Answer> answers;
	
	@OneToMany(mappedBy = "user")
	private List<Post> posts;
	
	@OneToMany(mappedBy = "user")
	private List<Comment> comments;
	
	@OneToMany(mappedBy = "user")
	private List<PostVote> postVotes;
	
	@OneToMany(mappedBy = "user")
	private List<CommentVote> commentVotes;
	
	@OneToMany(mappedBy = "user")
	private List<AnswerVote> answerVotes;
	
	@ManyToMany(mappedBy = "favoriteUsers")
	private List<Book> favoriteBooks;
	
	@ManyToMany(mappedBy = "finishedUsers")
	private List<Book> finishedBooks;
	
	@ManyToMany(mappedBy = "readingUsers")
	private List<Book> readingBooks;
	
	@ManyToMany(mappedBy = "wishlistUsers")
	private List<Book> wishlistBooks;
	
	@ManyToMany
	@JoinTable(name="follow_list")
	private List<User> users;
	
	@ManyToMany(mappedBy = "users")
	private List<User> followedUsers;
	

	// Default Constructor
	public User() {
		super();
	}

	public List<Book> getBooks() {
		return books;
	}

	public void setBooks(List<Book> books) {
		this.books = books;
	}

	// Getters and Setters
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getBiography() {
		return biography;
	}

	public void setBiography(String biography) {
		this.biography = biography;
	}

	public LocalDate getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDate createDate) {
		this.createDate = createDate;
	}

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", enabled=" + enabled
				+ ", role=" + role + ", email=" + email + ", firstName=" + firstName + ", lastName=" + lastName
				+ ", imgUrl=" + imgUrl + ", biography=" + biography + ", createDate=" + createDate + "]";
	}

}
