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

class LanguageTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Language language;

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
		language = em.find(Language.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		language = null;
	}

	@Test
	@DisplayName("Test basic language entity mapping")
	void test1() {
//		+----+---------+
//		| id | name    |
//		+----+---------+
//		|  1 | English |
//		+----+---------+
		assertNotNull(language);
		assertEquals("English", language.getName());
		assertEquals(1, language.getId());
	}
}
