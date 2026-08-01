package com.messbill.Repository;


import java.util.List;

import com.messbill.Entity.Bill;
import com.messbill.JPAutil.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class BillRepository {

    public void saveBill(Bill bill) {
        EntityManager em = JPAUtil.getEmf().createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(bill);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public List<Bill> getAllBills() {
        EntityManager em = JPAUtil.getEmf().createEntityManager();

        try {
            TypedQuery<Bill> query = em.createQuery("SELECT b FROM Bill b ORDER BY b.generatedDate DESC", Bill.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Bill findBillByStudentAndMonth(Integer studentId, String month, Integer year) {
        EntityManager em = JPAUtil.getEmf().createEntityManager();

        try {
            TypedQuery<Bill> query = em.createQuery(
                "SELECT b FROM Bill b WHERE b.student.studentId = :studentId AND b.month = :month AND b.year = :year",
                Bill.class
            );
            query.setParameter("studentId", studentId);
            query.setParameter("month", month);
            query.setParameter("year", year);

            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }
    
    public List<Bill> searchBills(
            String keyword,
            String month,
            Integer year,
            String billStatus,
            String studentStatus) {

        EntityManager em = JPAUtil.getEmf().createEntityManager();

        try {
            StringBuilder jpql = new StringBuilder(
                    "SELECT b FROM Bill b JOIN b.student s WHERE 1=1");

            if (keyword != null && !keyword.trim().isEmpty()) {
                jpql.append(" AND (LOWER(s.name) LIKE :keyword OR LOWER(s.rollNo) LIKE :keyword)");
            }

            if (month != null && !month.trim().isEmpty()) {
                jpql.append(" AND LOWER(b.month) = LOWER(:month)");
            }

            if (year != null) {
                jpql.append(" AND b.year = :year");
            }

            if (billStatus != null && !billStatus.trim().isEmpty()) {
                jpql.append(" AND LOWER(b.status) = LOWER(:billStatus)");
            }

            if (studentStatus != null && !studentStatus.trim().isEmpty()) {
                jpql.append(" AND LOWER(s.status) = LOWER(:studentStatus)");
            }

            jpql.append(" ORDER BY b.generatedDate DESC");

            TypedQuery<Bill> query = em.createQuery(jpql.toString(), Bill.class);

            if (keyword != null && !keyword.trim().isEmpty()) {
                query.setParameter("keyword", "%" + keyword.toLowerCase() + "%");
            }

            if (month != null && !month.trim().isEmpty()) {
                query.setParameter("month", month);
            }

            if (year != null) {
                query.setParameter("year", year);
            }

            if (billStatus != null && !billStatus.trim().isEmpty()) {
                query.setParameter("billStatus", billStatus);
            }

            if (studentStatus != null && !studentStatus.trim().isEmpty()) {
                query.setParameter("studentStatus", studentStatus);
            }

            return query.getResultList();

        } finally {
            em.close();
        }
    }    
    
    public Bill findBillById(Integer billId) {
        EntityManager em = JPAUtil.getEmf().createEntityManager();

        try {
            TypedQuery<Bill> query = em.createQuery(
                    "SELECT b FROM Bill b JOIN FETCH b.student WHERE b.billId = :billId",
                    Bill.class
            );
            query.setParameter("billId", billId);

            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }
    
    

	public void updateBill(Bill bill) {
		// TODO Auto-generated method stub
		
		EntityManager em = JPAUtil.getEmf().createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.merge(bill);
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
		
	}
	
	public Long countAllBills() {
	    EntityManager em = JPAUtil.getEmf().createEntityManager();
	    try {
	        TypedQuery<Long> query = em.createQuery(
	                "SELECT COUNT(b) FROM Bill b", Long.class);
	        return query.getSingleResult();
	    } finally {
	        em.close();
	    }
	}
	
	public Long countPendingBills() {
	    EntityManager em = JPAUtil.getEmf().createEntityManager();
	    try {
	        TypedQuery<Long> query = em.createQuery(
	                "SELECT COUNT(b) FROM Bill b WHERE b.status = 'Pending'",
	                Long.class);
	        return query.getSingleResult();
	    } finally {
	        em.close();
	    }
	}
	
	public Long countPaidBills() {
	    EntityManager em = JPAUtil.getEmf().createEntityManager();
	    try {
	        TypedQuery<Long> query = em.createQuery(
	                "SELECT COUNT(b) FROM Bill b WHERE b.status = 'Paid'",
	                Long.class);
	        return query.getSingleResult();
	    } finally {
	        em.close();
	    }
	}	
	
	public Long getTotalBreakfastCount() {

	    EntityManager em =
	            JPAUtil.getEmf()
	            .createEntityManager();

	    try {

	        TypedQuery<Long> query =
	                em.createQuery(

	        "SELECT COALESCE(SUM(b.breakfastCount),0) "
	      + "FROM Bill b",

	        Long.class);

	        return query.getSingleResult();

	    } finally {

	        em.close();
	    }
	}

	public Long getTotalLunchCount() {

	    EntityManager em =
	            JPAUtil.getEmf()
	            .createEntityManager();

	    try {

	        TypedQuery<Long> query =
	                em.createQuery(

	        "SELECT COALESCE(SUM(b.lunchCount),0) "
	      + "FROM Bill b",

	        Long.class);

	        return query.getSingleResult();

	    } finally {

	        em.close();
	    }
	}

	public Long getTotalDinnerCount() {

	    EntityManager em =
	            JPAUtil.getEmf()
	            .createEntityManager();

	    try {

	        TypedQuery<Long> query =
	                em.createQuery(

	        "SELECT COALESCE(SUM(b.dinnerCount),0) "
	      + "FROM Bill b",

	        Long.class);

	        return query.getSingleResult();

	    } finally {

	        em.close();
	    }
	}
	
	public Long getBillsCountByMonthAndYear(String month, Integer year) {
	    EntityManager em = JPAUtil.getEmf().createEntityManager();
	    try {
	        TypedQuery<Long> query = em.createQuery(
	                "SELECT COUNT(b) FROM Bill b WHERE b.month = :month AND b.year = :year",
	                Long.class);
	        query.setParameter("month", month);
	        query.setParameter("year", year);
	        return query.getSingleResult();
	    } finally {
	        em.close();
	    }
	}
	
	public Long getPaidBillsCountByMonthAndYear(String month, Integer year) {
	    EntityManager em = JPAUtil.getEmf().createEntityManager();
	    try {
	        TypedQuery<Long> query = em.createQuery(
	                "SELECT COUNT(b) FROM Bill b WHERE b.month = :month AND b.year = :year AND LOWER(b.status) = 'paid'",
	                Long.class);
	        query.setParameter("month", month);
	        query.setParameter("year", year);
	        return query.getSingleResult();
	    } finally {
	        em.close();
	    }
	}
	
	public Long getPendingBillsCountByMonthAndYear(String month, Integer year) {
	    EntityManager em = JPAUtil.getEmf().createEntityManager();
	    try {
	        TypedQuery<Long> query = em.createQuery(
	                "SELECT COUNT(b) FROM Bill b WHERE b.month = :month AND b.year = :year AND LOWER(b.status) = 'pending'",
	                Long.class);
	        query.setParameter("month", month);
	        query.setParameter("year", year);
	        return query.getSingleResult();
	    } finally {
	        em.close();
	    }
	}
	
	public Double getTotalAmountByMonthAndYear(String month, Integer year) {
	    EntityManager em = JPAUtil.getEmf().createEntityManager();
	    try {
	        TypedQuery<Double> query = em.createQuery(
	                "SELECT COALESCE(SUM(b.totalAmount), 0.0) FROM Bill b WHERE b.month = :month AND b.year = :year",
	                Double.class);
	        query.setParameter("month", month);
	        query.setParameter("year", year);
	        return query.getSingleResult();
	    } finally {
	        em.close();
	    }
	}
	
	public Long countBillsByDepartment(String department) {
	    EntityManager em = JPAUtil.getEmf().createEntityManager();
	    try {
	        TypedQuery<Long> query = em.createQuery(
	                "SELECT COUNT(b) FROM Bill b WHERE LOWER(b.student.department) = LOWER(:department)",
	                Long.class);
	        query.setParameter("department", department);
	        return query.getSingleResult();
	    } finally {
	        em.close();
	    }
	}
	
	public Long countPaidBillsByDepartment(String department) {
	    EntityManager em = JPAUtil.getEmf().createEntityManager();
	    try {
	        TypedQuery<Long> query = em.createQuery(
	                "SELECT COUNT(b) FROM Bill b WHERE LOWER(b.student.department) = LOWER(:department) AND LOWER(b.status) = 'paid'",
	                Long.class);
	        query.setParameter("department", department);
	        return query.getSingleResult();
	    } finally {
	        em.close();
	    }
	}
	

public Long countPendingBillsByDepartment(String department) {
    EntityManager em = JPAUtil.getEmf().createEntityManager();
    try {
        TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(b) FROM Bill b WHERE LOWER(b.student.department) = LOWER(:department) AND LOWER(b.status) = 'pending'",
                Long.class);
        query.setParameter("department", department);
        return query.getSingleResult();
    } finally {
        em.close();
    }
}


public Long getOverdueBillsCount() {
    EntityManager em = JPAUtil.getEmf().createEntityManager();
    try {
        TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(b) FROM Bill b " +
                "WHERE LOWER(b.status) <> 'paid' " +
                "AND b.dueDate IS NOT NULL " +
                "AND b.dueDate < CURRENT_DATE",
                Long.class);
        return query.getSingleResult();
    } finally {
        em.close();
    }
}

public Double getTotalBillAmount() {
    EntityManager em = JPAUtil.getEmf().createEntityManager();
    try {
        TypedQuery<Double> query = em.createQuery(
                "SELECT COALESCE(SUM(b.totalAmount), 0) FROM Bill b",
                Double.class);
        return query.getSingleResult();
    } finally {
        em.close();
    }
}

public Double getTotalLateFeeAmount() {
    EntityManager em = JPAUtil.getEmf().createEntityManager();
    try {
        TypedQuery<Double> query = em.createQuery(
                "SELECT COALESCE(SUM(b.lateFee), 0) FROM Bill b",
                Double.class);
        return query.getSingleResult();
    } finally {
        em.close();
    }
}

public Double getLateFeeByMonthAndYear(String month, Integer year) {
    EntityManager em = JPAUtil.getEmf().createEntityManager();
    try {
        TypedQuery<Double> query = em.createQuery(
                "SELECT COALESCE(SUM(b.lateFee), 0) FROM Bill b " +
                "WHERE LOWER(b.month) = LOWER(:month) AND b.year = :year",
                Double.class);
        query.setParameter("month", month);
        query.setParameter("year", year);
        return query.getSingleResult();
    } finally {
        em.close();
    }
}

}