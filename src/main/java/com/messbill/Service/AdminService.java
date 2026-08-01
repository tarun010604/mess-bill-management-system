package com.messbill.Service;

import com.messbill.Entity.Admin;
import com.messbill.Repository.AdminRepository;

public class AdminService {
	AdminRepository adminRepository=new AdminRepository();

	public String validateLogin(String username, String password) {
	    Admin admin = adminRepository.findByUsername(username);

	    if (admin == null) {
	        return "Invalid Username";
	    }

	    if (!admin.getPassword().equals(password)) {
	        return "Invalid Password";
	    }

	    return "SUCCESS";
	}
	
}
