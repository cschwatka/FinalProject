package com.skilldistillery.booknook.entities;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Comment {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String content;
	
	@Column(name="comment_date")
	@CreationTimestamp
	private LocalDateTime commentDate;
	
	private boolean enabled;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="post_id")
	private Post post;
	
	@ManyToOne
	@JoinColumn(name="in_reply_to_id")
	private Comment comment;
	
	@OneToMany(mappedBy="comment")
	private List<Comment> comments;
	
	@ManyToMany
	@JoinTable(name="comment_vote")
	private List<User> users;
	
	@OneToMany(mappedBy="comment")
	private List<CommentVote> commentVotes;
	

}
