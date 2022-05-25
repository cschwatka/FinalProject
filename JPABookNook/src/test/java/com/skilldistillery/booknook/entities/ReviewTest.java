package com.skilldistillery.booknook.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class ReviewTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Review review;

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
		review = em.find(Review.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		review = null;
	}

	@Test
	@DisplayName("Test basic review entity mapping")
	/*
	 * SELECT title FROM review WHERE id = 1;
+------------------------------------+
| title                              |
+------------------------------------+
| The Hobbit is WAY BETTER as a book |
+------------------------------------+
	 */
	void test_basic_Review_entity_mapping() {
		assertNotNull(review);
		assertEquals("The Hobbit is WAY BETTER as a book", review.getTitle());
	}
	
	@Test
	@DisplayName("Test Review foreign key relationship mapping")
	/*
	 * SELECT * FROM review;
+----+--------+---------+------------------------------------+---------------------+---------+---------+
| id | rating | enabled | title                              | review_date         | user_id | book_id |
+----+--------+---------+------------------------------------+---------------------+---------+---------+
|  1 |      5 |       1 | The Hobbit is WAY BETTER as a book | 2022-05-25 00:00:00 |       1 |       2 |
+----+--------+---------+------------------------------------+---------------------+---------+---------+
	 */
	void test_Review_foreign_key_relationship_mapping() {
		assertNotNull(review);
		assertEquals(1, review.getUser().getId());
		assertEquals(2, review.getBook().getId());
	}

}
