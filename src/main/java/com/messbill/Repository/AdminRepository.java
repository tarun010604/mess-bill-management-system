package com.messbill.Repository;

import com.messbill.Entity.Admin;
import com.messbill.JPAutil.JPAUtil;


import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;

public class AdminRepository {

	public void saveAdmin(Admin admin){
		
		
		EntityManager em=JPAUtil.getEmf().createEntityManager();
		EntityTransaction et=em.getTransaction();
		
		et.begin();
		
		em.persist(admin);
		et.commit();
		em.close();
		
}
	
	public Admin findByUsername(String username) {
		
		EntityManager em = JPAUtil.getEmf().createEntityManager();
		try {
			
			  Query q=em.createQuery("select a from Admin a where a.username= :username ");
			   q.setParameter("username", username);
			   
			  Object o= q.getSingleResult();
			  Admin admin =(Admin)o;
			  return admin;
		} catch (NoResultException e) {
		 return null;
		}
		finally {
			em.close();
		}
		
	}
}
