package com.skilldistillery.booknook.entities;

import java.util.Objects;

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
	
	

	public AnswerVote() {
		super();
	}

	public AnswerVoteId getId() {
		return id;
	}

	public void setId(AnswerVoteId id) {
		this.id = id;
	}

	public Boolean getVote() {
		return vote;
	}

	public void setVote(Boolean vote) {
		this.vote = vote;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Answer getAnswer() {
		return answer;
	}

	public void setAnswer(Answer answer) {
		this.answer = answer;
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
		AnswerVote other = (AnswerVote) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "AnswerVote [vote=" + vote + "]";
	}
	
	
	

	
	
}