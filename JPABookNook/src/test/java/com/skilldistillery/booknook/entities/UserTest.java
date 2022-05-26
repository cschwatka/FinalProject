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

class UserTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private User user;

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
		user = em.find(User.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		user = null;
	}

	@Test
	@DisplayName("Test basic user entity mapping")
	void test_basic_user_entity_mapping() {
		assertNotNull(user);
		assertEquals("admin", user.getUsername());
	}
	
	@Test
	void test_OneToMany_mapping_with_books() {
		/*
		 * 
		 */
		assertNotNull(user);
		assertTrue(user.getBooks().size() > 0);
	}
	
	@Test
	void test_ManyToMany_mapping_with_categories() {
		/*
		 * 
		 */
		assertNotNull(user);
		assertTrue(user.getCategories().size() > 0);
	}
	
	@Test
	void test_ManyToMany_mapping_with_authors() {
		/*
		 * 
		 */
		assertNotNull(user);
		assertTrue(user.getAuthors().size() > 0);
	}
	
	@Test
	void test_OneToMany_mapping_with_reviews() {
		/*
		 * 
		 */
		assertNotNull(user);
		assertTrue(user.getReviews().size() > 0);
	}
	
	@Test
	void test_OneToMany_mapping_with_answers() {
		/*
		 * 
		 */
		assertNotNull(user);
		assertTrue(user.getAnswers().size() > 0);
	}
	
	@Test
	void test_OneToMany_mapping_with_posts() {
		/*
		 * 
		 */
		assertNotNull(user);
		assertTrue(user.getPosts().size() > 0);
	}
	
	@Test
	void test_OneToMany_mapping_with_comments() {
		/*
		 * 
		 */
		assertNotNull(user);
		assertTrue(user.getComments().size() > 0);
	}
	
	@Test
	void test_OneToMany_mapping_with_postVotes() {
		/*
		 * 
		 */
		assertNotNull(user);
		assertTrue(user.getComments().size() > 0);
	}
	
}
