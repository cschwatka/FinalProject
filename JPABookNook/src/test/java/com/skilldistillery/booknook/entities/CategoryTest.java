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

class CategoryTest {
	
	private static EntityManagerFactory emf;
	private EntityManager em;
	private Category category;

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
		category = em.find(Category.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		category = null;
	}

	@Test
	@DisplayName("Test basic category entity mapping")
	void test1() {
//		+----+---------+-------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------+
//		| id | name    | description                                                                                                       | img_url                                                                         |
//		+----+---------+-------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------+
//		|  1 | Fiction | literature in the form of prose, especially short stories and novels, that describes imaginary events and people. | https://cdn.pixabay.com/photo/2017/09/10/14/24/manipulation-2735724_960_720.jpg |
//		+----+---------+-------------------------------------------------------------------------------------------------------------------+---------------------------------------------------------------------------------+
		assertNotNull(category);
		assertEquals("literature in the form of prose, especially short stories and novels, that describes imaginary events and people.", category.getDescription());
		assertEquals(1, category.getId());
		assertEquals("https://cdn.pixabay.com/photo/2017/09/10/14/24/manipulation-2735724_960_720.jpg", category.getImgUrl());
		assertEquals("Fiction", category.getName());
	}
	
}
