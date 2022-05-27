package com.skilldistillery.booknook.entities;

import java.util.Objects;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="post_vote")
public class PostVote {
	
	@EmbeddedId
	private PostVoteId id;
	
	private Boolean vote;
	
	@ManyToOne
	@JoinColumn(name="post_id")
	@MapsId(value="postId")
	private Post post;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="user_id")
	@MapsId(value="userId")
	private User user;

	public PostVote() {
		super();
	}

	public PostVoteId getId() {
		return id;
	}

	public void setId(PostVoteId id) {
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
		PostVote other = (PostVote) obj;
		return Objects.equals(id, other.id);
	}

	@Override
	public String toString() {
		return "PostVote [id=" + id + ", vote=" + vote + "]";
	}
	
	

}
