package com.skilldistillery.booknook.entities;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "answer_vote")
public class AnswerVote {
	
	@EmbeddedId
	private AnswerVoteId id;
	
	private Boolean vote;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	@MapsId(value = "userId")
	private User user;
	
	@ManyToOne
	@JoinColumn(name = "answer_id")
	@MapsId(value = "answerId")
	private Answer answer;

}