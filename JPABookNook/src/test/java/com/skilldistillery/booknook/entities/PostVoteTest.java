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

class PostVoteTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private PostVote postVote;

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
		PostVoteId pvid = new PostVoteId();
		pvid.setPostId(1);
		pvid.setUserId(1);
		postVote = em.find(PostVote.class, pvid);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		postVote = null;
	}

	@Test
	@DisplayName("Test basic PostVote entity mapping")
	/*
	 * SELECT * FROM post_vote WHERE post_id = 1;
+---------+---------+------+
| post_id | user_id | vote |
+---------+---------+------+
|       1 |       1 |    1 |
+---------+---------+------+
	 */
	void test_basic_PostVote_entity_mapping() {
		assertNotNull(postVote);
		assertEquals(true, postVote.getVote());
	}

}
