package com.skilldistillery.booknook.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.booknook.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	
	User findByUsername(String username);

}
