package com.messbill.Repository;

import java.util.List;

import com.messbill.Entity.PaymentSession;
import com.messbill.JPAutil.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class PaymentSessionRepository {

    public void save(PaymentSession session) {
        EntityManager em = JPAUtil.getEmf().createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(session);
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

    public PaymentSession findByToken(String token) {
        EntityManager em = JPAUtil.getEmf().createEntityManager();

        try {
            TypedQuery<PaymentSession> query = em.createQuery(
                    "SELECT ps FROM PaymentSession ps JOIN FETCH ps.bill b JOIN FETCH b.student WHERE ps.token = :token",
                    PaymentSession.class);
            query.setParameter("token", token);

            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public PaymentSession findByBillId(Integer billId) {
        EntityManager em = JPAUtil.getEmf().createEntityManager();

        try {
            TypedQuery<PaymentSession> query = em.createQuery(
                    "SELECT ps FROM PaymentSession ps WHERE ps.bill.billId = :billId ORDER BY ps.createdAt DESC",
                    PaymentSession.class);
            query.setParameter("billId", billId);
            query.setMaxResults(1);

            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public void update(PaymentSession session) {
        EntityManager em = JPAUtil.getEmf().createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.merge(session);
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

    public List<PaymentSession> findAll() {
        EntityManager em = JPAUtil.getEmf().createEntityManager();

        try {
            TypedQuery<PaymentSession> query = em.createQuery(
                    "SELECT ps FROM PaymentSession ps ORDER BY ps.createdAt DESC",
                    PaymentSession.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}