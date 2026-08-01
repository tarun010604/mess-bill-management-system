package com.messbill.Repository;

import java.time.LocalDate;
import java.util.List;

import com.messbill.Entity.Attendance;
import com.messbill.JPAutil.JPAUtil;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class AttendanceRepository {

    public Attendance findAttendance(Integer studentId, LocalDate date,String mealType) {

        EntityManager em =
                JPAUtil.getEmf()
                       .createEntityManager();

        try {

            TypedQuery<Attendance> query =
                    em.createQuery(

                    "SELECT a FROM Attendance a " +
                    "WHERE a.student.studentId = :studentId " +
                    "AND a.date = :date " +
                    "AND a.mealType = :mealType",

                    Attendance.class);

            query.setParameter(
                    "studentId",
                    studentId);

            query.setParameter(
                    "date",
                    date);

            query.setParameter(
                    "mealType",
                    mealType);

            return query
                    .getResultStream()
                    .findFirst()
                    .orElse(null);

        } finally {
            em.close();
        }
    }

    public void saveAttendance(
            Attendance attendance) {

        EntityManager em =
                JPAUtil.getEmf()
                       .createEntityManager();

        EntityTransaction tx =
                em.getTransaction();

        try {

            tx.begin();

            Attendance existing =
                    findAttendance(
                            attendance
                            .getStudent()
                            .getStudentId(),

                            attendance.getDate(),

                            attendance.getMealType());

            if(existing == null) {

                em.persist(attendance);

            } else {

                existing.setStatus(
                        attendance.getStatus());

                em.merge(existing);
            }

            tx.commit();

        } catch (Exception e) {

            if(tx.isActive()) {
                tx.rollback();
            }

            throw e;

        } finally {
            em.close();
        }
    }
    
    public Integer countMealByStudentMonthYear(Integer studentId, String month, Integer year, String mealType) {

        EntityManager em = JPAUtil.getEmf().createEntityManager();

        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(a) FROM Attendance a " +
                    "WHERE a.student.studentId = :studentId " +
                    "AND a.mealType = :mealType " +
                    "AND FUNCTION('MONTH', a.date) = :monthValue " +
                    "AND FUNCTION('YEAR', a.date) = :yearValue " +
                    "AND a.status = 'Present'",
                    Long.class);

            query.setParameter("studentId", studentId);
            query.setParameter("mealType", mealType);

            int monthValue = getMonthNumber(month);
            query.setParameter("monthValue", monthValue);
            query.setParameter("yearValue", year);

            Long result = query.getSingleResult();
            return result.intValue();

        } finally {
            em.close();
        }
    }
    
    private int getMonthNumber(String month)
    {
    	if(month==null)return 0;
    	switch (month.toLowerCase()) {
		case "january":
			return 1;
		case "february":
			return 2;
		case "march":
			return 3;
		case "april":
			return 4;
		case "may":
			return 5;
		case "june":
			return 6;
		case "july":
			return 7;
		case "august":
			return 8;
		case "september":
			return 9 ;
		case "october":
			return 10 ;	
		case "november":
				return 11 ;
		case "december":
			return 12 ;
		default:
			return 0;
			
			
				
		

		
		}
    }
    
    public Long getTotalMealCount(
            String mealType) {

        EntityManager em =
                JPAUtil.getEmf()
                .createEntityManager();

        try {

            TypedQuery<Long> query =
                    em.createQuery(

            "SELECT COUNT(a) "
          + "FROM Attendance a "
          + "WHERE LOWER(a.mealType)=LOWER(:mealType)",

            Long.class);

            query.setParameter(
                    "mealType",
                    mealType);

            return query.getSingleResult();

        } finally {

            em.close();
        }
    }
    
    public Long getMealCountByYear(
            String mealType,
            Integer year) {

        EntityManager em =
                JPAUtil.getEmf()
                .createEntityManager();

        try {

            TypedQuery<Long> query =
                    em.createQuery(

            "SELECT COUNT(a) "
          + "FROM Attendance a "
          + "WHERE LOWER(a.mealType)=LOWER(:mealType) "
          + "AND YEAR(a.date)=:year",

            Long.class);

            query.setParameter(
                    "mealType",
                    mealType);

            query.setParameter(
                    "year",
                    year);

            return query.getSingleResult();

        } finally {

            em.close();
        }
    }    
    public Long getMealCountByMonthAndYear(
            String mealType,
            String month,
            Integer year) {

        EntityManager em =
                JPAUtil.getEmf()
                .createEntityManager();

        try {

            int monthNumber = getMonthNumber(month);

            TypedQuery<Long> query =
                    em.createQuery(

            "SELECT COUNT(a) "
          + "FROM Attendance a "
          + "WHERE LOWER(a.mealType)=LOWER(:mealType) "
          + "AND MONTH(a.date)=:month "
          + "AND YEAR(a.date)=:year",

            Long.class);

            query.setParameter(
                    "mealType",
                    mealType);

            query.setParameter(
                    "month",
                    monthNumber);

            query.setParameter(
                    "year",
                    year);

            return query.getSingleResult();

        } finally {

            em.close();
        }
    }
    
    public boolean existsAttendance(Integer studentId, LocalDate date, String mealType) {
        EntityManager em = JPAUtil.getEmf().createEntityManager();

        try {
            TypedQuery<Long> query = em.createQuery(
                    "SELECT COUNT(a) FROM Attendance a " +
                    "WHERE a.student.studentId = :studentId " +
                    "AND a.date = :date " +
                    "AND LOWER(a.mealType) = LOWER(:mealType)",
                    Long.class);

            query.setParameter("studentId", studentId);
            query.setParameter("date", date);
            query.setParameter("mealType", mealType);

            return query.getSingleResult() > 0;
        } finally {
            em.close();
        }
    }
}