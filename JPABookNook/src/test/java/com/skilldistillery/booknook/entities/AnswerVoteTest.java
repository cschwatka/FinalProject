package com.skilldistillery.booknook.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class AnswerVoteTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private AnswerVote answerVote;

	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPABookNook");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		AnswerVoteId avid = new AnswerVoteId();
		avid.setAnswerId(1);
		avid.setUserId(2);
		answerVote = em.find(AnswerVote.class, avid);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		answerVote = null;
	}

	@Test
	@DisplayName("Test basic AnswerVote entity mapping")
	/*
	 * SELECT * FROM answer_vote;
	+-----------+---------+------+
	| answer_id | user_id | vote |
	+-----------+---------+------+
	|         1 |       2 |    1 |
	+-----------+---------+------+
	 */
	void test_basic_AnswerVote_entity_mapping() {
		assertNotNull(answerVote);
		assertEquals(true, answerVote.getVote());
	}

}
