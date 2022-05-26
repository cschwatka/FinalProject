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

class AnswerTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Answer answer;

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
		answer = em.find(Answer.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		answer = null;
	}

	@Test
	@DisplayName("Test basic answer entity mapping")
	void test1() {
//		+----+------------------------+---------------------+---------+---------+-------------+----------------+
//		| id | content                | answer_date         | enabled | user_id | question_id | in_reply_to_id |
//		+----+------------------------+---------------------+---------+---------+-------------+----------------+
//		|  1 | Absolutely you should! | 2022-05-25 00:00:00 |       1 |       1 |           1 |           NULL |
//		+----+------------------------+---------------------+---------+---------+-------------+----------------+
		assertNotNull(answer);
		assertEquals("Absolutely you should!", answer.getContent());
		assertEquals(1, answer.getId());
		assertEquals("2022-05-25T00:00", answer.getAnswerDate().toString());
		assertEquals(true, answer.isEnabled());
	}
	
	@Test
	@DisplayName("Test answer foreign key relationship")
	void test2() {
//		+----+------------------------+---------------------+---------+---------+-------------+----------------+
//		| id | content                | answer_date         | enabled | user_id | question_id | in_reply_to_id |
//		+----+------------------------+---------------------+---------+---------+-------------+----------------+
//		|  1 | Absolutely you should! | 2022-05-25 00:00:00 |       1 |       1 |           1 |           NULL |
//		+----+------------------------+---------------------+---------+---------+-------------+----------------+
		assertNotNull(answer);
		assertEquals(1, answer.getUser().getId());
		assertEquals(1, answer.getQuestion().getId());
		assertNull(answer.getAnswer());
	}

}
