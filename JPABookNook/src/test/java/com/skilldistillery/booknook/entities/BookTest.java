package com.skilldistillery.booknook.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class BookTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Book book;

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
		book = em.find(Book.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		book = null;
	}

	@Test
	void test_basic_book_entity_mapping() {
		assertNotNull(book);
		assertEquals("The Fellowship of the Ring", book.getTitle());
	}
	
	@Test
	void test_book_MTO_language_mapping() {
		/*
		 * SELECT l.name FROM book b JOIN language l ON b.language_id = l.id WHERE b.id = 1;
+---------+
| name    |
+---------+
| English |
+---------+
		 */
		
		assertNotNull(book);
		assertEquals("English", book.getLanguage().getName());
	}
	
	@Test
	void test_book_MTO_user_mapping() {
		/*
		 * SELECT u.username FROM book b JOIN user u ON b.user_id = u.id WHERE b.id = 1;
+----------+
| username |
+----------+
| admin    |
+----------+
		 */
		
		assertNotNull(book);
		assertEquals("admin", book.getUser().getUsername());
	}
	
	@Test
	void test_book_MTM_categories_mapping() {
		/*
		 * SELECT COUNT(*) FROM book_to_category where book_id = 1;
+----------+
| COUNT(*) |
+----------+
|        1 |
+----------+
		 */
		
		assertNotNull(book);
		assertNotNull(book.getCategories());
		assertEquals(1, book.getCategories().size());
		assertTrue(book.getCategories().size() > 0);
	}
	
	

}
