package com.messbill.test;

import com.messbill.Entity.Admin;
import com.messbill.Repository.AdminRepository;

public class TestAdminSave {
	

	public static void main(String[] args) {
		
		Admin admin=new Admin();
		
		admin.setUsername("Tarun");
		admin.setPassword("Tarun@010604");
		admin.setEmail("tarun@gmail.com");
		
		
		AdminRepository ar= new AdminRepository();
		
		ar.saveAdmin(admin);
		System.out.println("Admin saved successfully");
		
				
	}
}
