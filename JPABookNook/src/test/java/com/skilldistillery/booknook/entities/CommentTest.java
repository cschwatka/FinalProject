package com.skilldistillery.booknook.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class CommentTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Comment comment;

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
		comment = em.find(Comment.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		comment = null;
	}

	@Test
	@DisplayName("Test basic comment entity mapping")
	void test1() {
//		+----+--------------------------------------------+---------------------+---------+---------+---------+----------------+
//		| id | content                                    | comment_date        | enabled | user_id | post_id | in_reply_to_id |
//		+----+--------------------------------------------+---------------------+---------+---------+---------+----------------+
//		|  1 | That's huge!!! Get ready for an adventure! | 2022-05-25 15:10:10 |       1 |       1 |       1 |           NULL |
//		+----+--------------------------------------------+---------------------+---------+---------+---------+----------------+
		assertNotNull(comment);
		assertEquals("That's huge!!! Get ready for an adventure!", comment.getContent());
		assertEquals(1, comment.getId());
		assertEquals("2022-05-25T15:10:10", comment.getCommentDate().toString());
		assertEquals(true, comment.isEnabled());
	}
	
	@Test
	@DisplayName("Test comment foreign key relationship")
	void test2() {
//		+----+--------------------------------------------+---------------------+---------+---------+---------+----------------+
//		| id | content                                    | comment_date        | enabled | user_id | post_id | in_reply_to_id |
//		+----+--------------------------------------------+---------------------+---------+---------+---------+----------------+
//		|  1 | That's huge!!! Get ready for an adventure! | 2022-05-25 15:10:10 |       1 |       1 |       1 |           NULL |
//		+----+--------------------------------------------+---------------------+---------+---------+---------+----------------+
		assertNotNull(comment);
		assertEquals(1, comment.getUser().getId());
		assertEquals(1, comment.getPost().getId());
		assertNull(comment.getComment());
	}

}
