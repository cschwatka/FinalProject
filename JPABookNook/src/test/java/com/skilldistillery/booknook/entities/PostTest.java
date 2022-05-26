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

class PostTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Post post;

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
		post = em.find(Post.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		post = null;
	}

	@Test
	@DisplayName("Test basic post entity mapping")
	void test1() {
//		+----+---------------------------------------------------------------------------------------------------------------------------+------------------+---------------------+---------+---------+
//		| id | content                                                                                                                   | title            | post_date           | enabled | user_id |
//		+----+---------------------------------------------------------------------------------------------------------------------------+------------------+---------------------+---------+---------+
//		|  1 | I'm a huge Tolkien fan, but I've only ever watched the movies. I am going to start reading the books and am super excited | New Tolkien fan! | 2022-05-25 15:10:01 |       1 |       2 |
//		+----+---------------------------------------------------------------------------------------------------------------------------+------------------+---------------------+---------+---------+

		assertNotNull(post);
		assertEquals("I'm a huge Tolkien fan, but I've only ever watched the movies. I am going to start reading the books and am super excited", post.getContent());
		assertEquals("New Tolkien fan!", post.getTitle());
		assertEquals(1, post.getId());
		assertEquals("2022-05-25T15:10:01", post.getPostDate().toString());
		assertEquals(true, post.isEnabled());
	}
	
	@Test
	@DisplayName("Test post foreign key relationship")
	void test2() {
//		+----+---------------------------------------------------------------------------------------------------------------------------+------------------+---------------------+---------+---------+
//		| id | content                                                                                                                   | title            | post_date           | enabled | user_id |
//		+----+---------------------------------------------------------------------------------------------------------------------------+------------------+---------------------+---------+---------+
//		|  1 | I'm a huge Tolkien fan, but I've only ever watched the movies. I am going to start reading the books and am super excited | New Tolkien fan! | 2022-05-25 15:10:01 |       1 |       2 |
//		+----+---------------------------------------------------------------------------------------------------------------------------+------------------+---------------------+---------+---------+

		assertNotNull(post);
		assertEquals(2, post.getUser().getId());
	}

}
