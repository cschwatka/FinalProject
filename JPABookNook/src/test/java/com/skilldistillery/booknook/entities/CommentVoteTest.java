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

class CommentVoteTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private CommentVote commentVote;

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
		CommentVoteId cvid = new CommentVoteId();
		cvid.setCommentId(1);
		cvid.setUserId(2);
		commentVote = em.find(CommentVote.class, cvid);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		commentVote = null;
	}

	@Test
	@DisplayName("Test basic CommentVote entity mapping")
	/*
	 * SELECT * FROM comment_vote WHERE comment_id = 1;
	+---------+------------+------+
	| user_id | comment_id | vote |
	+---------+------------+------+
	|       2 |          1 |    1 |
	+---------+------------+------+
	 */
	void test_basic_CommentVote_entity_mapping() {
		assertNotNull(commentVote);
		assertEquals(true, commentVote.getVote());
	}

}
