package com.messbill.Repository;

import java.time.LocalDate;
import java.util.List;

import com.messbill.Entity.Payment;
import com.messbill.JPAutil.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class PaymentRepository {

	public void savePayment(Payment payment)
	{
		  EntityManager em = JPAUtil.getEmf().createEntityManager();
	        EntityTransaction tx = em.getTransaction();

	        try {
	            tx.begin();
	            em.persist(payment);
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
	
	 public List<Payment> getAllPayments() {
	        EntityManager em = JPAUtil.getEmf().createEntityManager();

	        try {
	            TypedQuery<Payment> query = em.createQuery(
	                    "SELECT p FROM Payment p JOIN FETCH p.bill b JOIN FETCH b.student ORDER BY p.paymentDate DESC",
	                    Payment.class);
	            return query.getResultList();
	        } finally {
	            em.close();
	        }
	    }
	 
	 public Long countAllPayments() {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();
		    try {
		        TypedQuery<Long> query = em.createQuery(
		                "SELECT COUNT(p) FROM Payment p", Long.class);
		        return query.getSingleResult();
		    } finally {
		        em.close();
		    }
		}
	 
	 public Long countPaymentsThisMonth(
		        Integer month,
		        Integer year) {

		    EntityManager em =
		            JPAUtil.getEmf()
		            .createEntityManager();

		    try {

		        TypedQuery<Long> query =
		                em.createQuery(

		        "SELECT COUNT(p) "
		      + "FROM Payment p "
		      + "WHERE MONTH(p.paymentDate)=:month "
		      + "AND YEAR(p.paymentDate)=:year",

		        Long.class);

		        query.setParameter(
		                "month",
		                month);

		        query.setParameter(
		                "year",
		                year);

		        return query.getSingleResult();

		    } finally {

		        em.close();
		    }
		}
	 


		public Long countPaymentsByDateRange(LocalDate startDate, LocalDate endDate) {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();
		    try {
		        TypedQuery<Long> query = em.createQuery(
		                "SELECT COUNT(p) FROM Payment p WHERE p.paymentDate BETWEEN :startDate AND :endDate",
		                Long.class);
		        query.setParameter("startDate", startDate);
		        query.setParameter("endDate", endDate);
		        return query.getSingleResult();
		    } finally {
		        em.close();
		    }
		}
	
		public boolean existsByBillId(Integer billId) {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();

		    try {
		        TypedQuery<Long> query = em.createQuery(
		                "SELECT COUNT(p) FROM Payment p WHERE p.bill.billId = :billId",
		                Long.class);

		        query.setParameter("billId", billId);
		        return query.getSingleResult() > 0;
		    } finally {
		        em.close();
		    }
		}

		public boolean existsByReferenceNo(String referenceNo) {
		    EntityManager em = JPAUtil.getEmf().createEntityManager();

		    try {
		        TypedQuery<Long> query = em.createQuery(
		                "SELECT COUNT(p) FROM Payment p WHERE LOWER(p.referenceNo) = LOWER(:referenceNo)",
		                Long.class);

		        query.setParameter("referenceNo", referenceNo);
		        return query.getSingleResult() > 0;
		    } finally {
		        em.close();
		    }
		}
}
