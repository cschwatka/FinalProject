package com.skilldistillery.booknook.services;

import com.skilldistillery.booknook.entities.User;

public interface AuthService {

	public User register(User user);
	
	public User getUserByUsername(String username); 
}
