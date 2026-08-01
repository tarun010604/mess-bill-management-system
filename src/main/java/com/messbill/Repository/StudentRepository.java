package com.messbill.Repository;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.messbill.Entity.Student;
import com.messbill.JPAutil.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

public class StudentRepository {

	public void saveStudent(Student s)
	{
		
		EntityManager em=JPAUtil.getEmf().createEntityManager();
		EntityTransaction et=em.getTransaction();


		
		
		et.begin();
		em.persist(s);
		et.commit();
		
		em.close();
		
	}
	
	public List<Student> getAllStudents()
	{
		EntityManager em=JPAUtil.getEmf().createEntityManager();
		
		try {
			Query q=em.createQuery("select s from Student s");
			
			List<Student>std=q.getResultList();
			return std;
			
		} finally {
			// TODO: handle finally claue
			
			em.close();
		}
		
		
		}
		
	 
	
	
	 public List<Student> searchStudents(String year, String department, String rollNo, String name, String hostelRoomNo) {
	        EntityManager em = JPAUtil.getEmf().createEntityManager();

	        try {
	            StringBuilder jpql = new StringBuilder("SELECT s FROM Student s WHERE 1=1");
	            Map<String, Object> params = new HashMap<>();

	            if (year != null && !year.trim().isEmpty()) {
	                jpql.append(" AND s.year = :year");
	                params.put("year", year);
	            }

	            if (department != null && !department.trim().isEmpty()) {
	                jpql.append(" AND s.department = :department");
	                params.put("department", department);
	            }

	            if (rollNo != null && !rollNo.trim().isEmpty()) {
	                jpql.append(" AND LOWER(s.rollNo) LIKE :rollNo");
	                params.put("rollNo", "%" + rollNo.toLowerCase() + "%");
	            }

	            if (name != null && !name.trim().isEmpty()) {
	                jpql.append(" AND LOWER(s.name) LIKE :name");
	                params.put("name", "%" + name.toLowerCase() + "%");
	            }

	            if (hostelRoomNo != null && !hostelRoomNo.trim().isEmpty()) {
	                jpql.append(" AND LOWER(s.hostelRoomNo) LIKE :hostelRoomNo");
	                params.put("hostelRoomNo", "%" + hostelRoomNo.toLowerCase() + "%");
	            }

	            TypedQuery<Student> query = em.createQuery(jpql.toString(), Student.class);
	            params.forEach(query::setParameter);

	            return query.getResultList();

	        } finally {
	            em.close();
	        }
	    }
	 
	   public List<Student> getStudentsByYear(String year) {
	        EntityManager em = JPAUtil.getEmf().createEntityManager();

	        try {
	            TypedQuery<Student> query = em.createQuery(
	                "SELECT s FROM Student s WHERE s.year = :year",
	                Student.class
	            );
	            query.setParameter("year", year);
	            return query.getResultList();
	        } finally {
	            em.close();
	        }
	    }
	   
	   public Student findById(Integer studentId) {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();

		    try {
		        return em.find(Student.class, studentId);
		    } finally {
		        em.close();
		    }
		}
	   public Long countAllStudents() {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();
		    try {
		        TypedQuery<Long> query = em.createQuery(
		                "SELECT COUNT(s) FROM Student s", Long.class);
		        return query.getSingleResult();
		    } finally {
		        em.close();
		    }
		}

		public Long countActiveStudents() {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();
		    try {
		        TypedQuery<Long> query = em.createQuery(
		                "SELECT COUNT(s) FROM Student s WHERE s.status = 'Active'",
		                Long.class);
		        return query.getSingleResult();
		    } finally {
		        em.close();
		    }
		}
		public Long countInactiveStudents() {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();
		    try {
		        TypedQuery<Long> query = em.createQuery(
		                "SELECT COUNT(s) FROM Student s WHERE LOWER(s.status) IN ('inactive', 'left hostel')",
		                Long.class);
		        return query.getSingleResult();
		    } finally {
		        em.close();
		    }
		}	
		public Long countStudentsByYear(String year) {

		    EntityManager em =
		            JPAUtil.getEmf()
		            .createEntityManager();

		    try {

		        TypedQuery<Long> query =
		                em.createQuery(

		        "SELECT COUNT(s) FROM Student s WHERE s.year = :year",

		        Long.class);

		        query.setParameter("year", year);

		        return query.getSingleResult();

		    } finally {

		        em.close();
		    }
		}
		
		public Long countStudentsByDepartment(
		        String department) {

		    EntityManager em =
		            JPAUtil.getEmf()
		            .createEntityManager();

		    try {

		        TypedQuery<Long> query =
		                em.createQuery(

		        "SELECT COUNT(s) "
		      + "FROM Student s "
		      + "WHERE s.department = :department",

		        Long.class);

		        query.setParameter(
		                "department",
		                department);

		        return query.getSingleResult();

		    } finally {

		        em.close();
		    }
		}
		
		public void updateStudentStatus(
		        Integer studentId,
		        String status) {

		    EntityManager em =
		            JPAUtil.getEmf()
		            .createEntityManager();

		    EntityTransaction tx =
		            em.getTransaction();

		    try {

		        tx.begin();

		        Student student =
		                em.find(
		                        Student.class,
		                        studentId);

		        if(student != null){

		            student.setStatus(status);

		            em.merge(student);
		        }

		        tx.commit();

		    } catch(Exception e){

		        if(tx.isActive()){

		            tx.rollback();
		        }

		        throw e;

		    } finally {

		        em.close();
		    }
		}
		
		
		public java.util.List<Student> getActiveStudents() {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();
		    try {
		        TypedQuery<Student> query = em.createQuery(
		                "SELECT s FROM Student s WHERE LOWER(s.status) = 'active'",
		                Student.class);
		        return query.getResultList();
		    } finally {
		        em.close();
		    }
		}

		public java.util.List<Student> getActiveStudentsByYear(String year) {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();
		    try {
		        TypedQuery<Student> query = em.createQuery(
		                "SELECT s FROM Student s WHERE LOWER(s.status) = 'active' AND LOWER(s.year) = LOWER(:year)",
		                Student.class);
		        query.setParameter("year", year);
		        return query.getResultList();
		    } finally {
		        em.close();
		    }
		}
		
	

		public List<Student> searchActiveStudents(String year, String department, String rollNo, String name, String hostelRoomNo) {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();

		    try {
		        StringBuilder jpql = new StringBuilder("SELECT s FROM Student s WHERE LOWER(s.status) = 'active'");
		        Map<String, Object> params = new HashMap<>();

		        if (year != null && !year.trim().isEmpty()) {
		            jpql.append(" AND LOWER(s.year) = LOWER(:year)");
		            params.put("year", year);
		        }

		        if (department != null && !department.trim().isEmpty()) {
		            jpql.append(" AND LOWER(s.department) = LOWER(:department)");
		            params.put("department", department);
		        }

		        if (rollNo != null && !rollNo.trim().isEmpty()) {
		            jpql.append(" AND LOWER(s.rollNo) LIKE :rollNo");
		            params.put("rollNo", "%" + rollNo.toLowerCase() + "%");
		        }

		        if (name != null && !name.trim().isEmpty()) {
		            jpql.append(" AND LOWER(s.name) LIKE :name");
		            params.put("name", "%" + name.toLowerCase() + "%");
		        }

		        if (hostelRoomNo != null && !hostelRoomNo.trim().isEmpty()) {
		            jpql.append(" AND LOWER(s.hostelRoomNo) LIKE :hostelRoomNo");
		            params.put("hostelRoomNo", "%" + hostelRoomNo.toLowerCase() + "%");
		        }

		        TypedQuery<Student> query = em.createQuery(jpql.toString(), Student.class);
		        params.forEach(query::setParameter);

		        return query.getResultList();

		    } finally {
		        em.close();
		    }
		}
		
		public Student findStudentById(Integer studentId) {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();
		    try {
		        return em.find(Student.class, studentId);
		    } finally {
		        em.close();
		    }
		}

		public void updateStudent(Student student) {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();
		    EntityTransaction tx = em.getTransaction();

		    try {
		        tx.begin();
		        em.merge(student);
		        tx.commit();
		    } catch (Exception e) {
		        if (tx.isActive()) tx.rollback();
		        throw e;
		    } finally {
		        em.close();
		    }
		}
}
