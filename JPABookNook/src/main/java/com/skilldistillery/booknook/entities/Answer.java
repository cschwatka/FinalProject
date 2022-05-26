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

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Answer {

	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String content;
	
	@JsonIgnoreProperties({"user", "question", "answer"})
	
	@Column(name="answer_date")
	@CreationTimestamp
	private LocalDateTime answerDate;
	
	private boolean enabled;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="question_id")
	private Question question;
	
	@ManyToOne
	@JoinColumn(name="in_reply_to_id")
	private Answer answer;
	
	@OneToMany(mappedBy="answer")
	private List<Answer> answers;
	
	@OneToMany(mappedBy="answer")
	private List<AnswerVote> answerVotes;

	public Answer() {
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





	public LocalDateTime getAnswerDate() {
		return answerDate;
	}





	public void setAnswerDate(LocalDateTime answerDate) {
		this.answerDate = answerDate;
	}





	public boolean isEnabled() {
		return enabled;
	}





	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}





	public User getUser() {
		return user;
	}





	public void setUser(User user) {
		this.user = user;
	}





	public Question getQuestion() {
		return question;
	}





	public void setQuestion(Question question) {
		this.question = question;
	}





	public Answer getAnswer() {
		return answer;
	}





	public void setAnswer(Answer answer) {
		this.answer = answer;
	}





	public List<Answer> getAnswers() {
		return answers;
	}





	public void setAnswers(List<Answer> answers) {
		this.answers = answers;
	}





	public List<AnswerVote> getAnswerVotes() {
		return answerVotes;
	}





	public void setAnswerVotes(List<AnswerVote> answerVotes) {
		this.answerVotes = answerVotes;
	}





	@Override
	public String toString() {
		return "Answer [id=" + id + ", content=" + content + ", answerDate=" + answerDate + ", enabled=" + enabled
				+ "]";
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
		Answer other = (Answer) obj;
		return id == other.id;
	}
	
	
	
}
