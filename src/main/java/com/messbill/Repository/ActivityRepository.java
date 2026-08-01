package com.messbill.Repository;

import java.util.List;

import com.messbill.Entity.ActivityLog;
import com.messbill.JPAutil.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class ActivityRepository {

    public void saveActivity(ActivityLog activityLog) {
        EntityManager em = JPAUtil.getEmf().createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(activityLog);
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

    public List<ActivityLog> getLatestActivities() {
        EntityManager em = JPAUtil.getEmf().createEntityManager();

        try {
            TypedQuery<ActivityLog> query = em.createQuery(
                    "SELECT a FROM ActivityLog a ORDER BY a.activityDate DESC, a.activityId DESC",
                    ActivityLog.class
            );
            query.setMaxResults(5);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
}