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

class QuestionTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Question question;

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
		question = em.find(Question.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		question = null;
	}

	@Test
	@DisplayName("Test basic question entity mapping")
	void test1() {
//		+----+-------------------------------------------------------------+---------------------+---------+---------+---------+
//		| id | content                                                     | question_date       | enabled | user_id | book_id |
//		+----+-------------------------------------------------------------+---------------------+---------+---------+---------+
//		|  1 | Should I read The Hobbit if I've already watched the movie? | 2022-05-25 00:00:00 |       1 |       2 |       2 |
//		+----+-------------------------------------------------------------+---------------------+---------+---------+---------+
		assertNotNull(question);
		assertEquals("Should I read The Hobbit if I've already watched the movie?", question.getContent());
		assertEquals(1, question.getId());
		assertEquals("2022-05-25T00:00", question.getQuestionDate().toString());
		assertEquals(true, question.isEnabled());
	}
	
	@Test
	@DisplayName("Test question foreign key relationship")
	void test2() {
//		+----+-------------------------------------------------------------+---------------------+---------+---------+---------+
//		| id | content                                                     | question_date       | enabled | user_id | book_id |
//		+----+-------------------------------------------------------------+---------------------+---------+---------+---------+
//		|  1 | Should I read The Hobbit if I've already watched the movie? | 2022-05-25 00:00:00 |       1 |       2 |        1|
//		+----+-------------------------------------------------------------+---------------------+---------+---------+---------+
		assertNotNull(question);
		assertEquals(2, question.getUser().getId());
		assertEquals(1, question.getBook().getId());
	}

}
