package com.skilldistillery.booknook.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "comment_vote")
public class CommentVote {
	
	@EmbeddedId
	private CommentVoteId id;
	
	private Boolean vote;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	@MapsId(value = "user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name = "comment_id")
	@MapsId(value = "comment_id")
	private Comment comment;

	public CommentVote() {
		super();
	}

	public CommentVoteId getId() {
		return id;
	}

	public void setId(CommentVoteId id) {
		this.id = id;
	}

	public Boolean getVote() {
		return vote;
	}

	public void setVote(Boolean vote) {
		this.vote = vote;
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
		CommentVote other = (CommentVote) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "CommentVote [id=" + id + ", vote=" + vote + "]";
	}
	
}