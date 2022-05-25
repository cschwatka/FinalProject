package com.skilldistillery.booknook.entities;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class AnswerVoteId implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Column(name = "user_id")
	private int userId;
	
	@Column(name = "answer_id")
	private int answerId;
	
	

	public AnswerVoteId() {
		super();
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getAnswerId() {
		return answerId;
	}

	public void setAnswerId(int answerId) {
		this.answerId = answerId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		return Objects.hash(answerId, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AnswerVoteId other = (AnswerVoteId) obj;
		return answerId == other.answerId && userId == other.userId;
	}

	@Override
	public String toString() {
		return "AnswerVoteId [userId=" + userId + ", answerId=" + answerId + "]";
	}
	
}