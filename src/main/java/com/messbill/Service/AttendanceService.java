package com.messbill.Service;

import com.messbill.Entity.Attendance;
import com.messbill.Entity.Student;
import com.messbill.Repository.AttendanceRepository;
import com.messbill.Repository.StudentRepository;

public class AttendanceService {

    private AttendanceRepository
            attendanceRepository =
            new AttendanceRepository();
    
    private StudentRepository studentRepository = new StudentRepository();

    public void saveAttendance(
            Attendance attendance) {
    	
    	
    	 if (attendance == null || attendance.getStudent() == null || attendance.getStudent().getStudentId() == null) {
             throw new RuntimeException("Invalid attendance data");
         }

         Integer studentId = attendance.getStudent().getStudentId();
         Student student = studentRepository.findById(studentId);

         if (student == null) {
             throw new RuntimeException("Student not found");
         }

         if (student.getStatus() == null || !"Active".equalsIgnoreCase(student.getStatus())) {
             throw new RuntimeException("Inactive student cannot mark attendance");
         }
         
         boolean alreadyMarked = attendanceRepository.existsAttendance(
                 studentId,
                 attendance.getDate(),
                 attendance.getMealType()
         );

         if (alreadyMarked) {
             throw new RuntimeException(attendance.getMealType() + " already marked for this student today");
         }

         attendance.setStudent(student);
         attendanceRepository.saveAttendance(attendance);
    }
    
    public Long getTotalMealCount(
            String mealType) {

        return attendanceRepository
                .getTotalMealCount(
                        mealType);
    }

    public Long getMealCountByYear(
            String mealType,
            Integer year) {

        return attendanceRepository
                .getMealCountByYear(
                        mealType,
                        year);
    }
    
    
    public Long getMealCountByMonthAndYear(
            String mealType,
            String month,
            Integer year) {

        return attendanceRepository
                .getMealCountByMonthAndYear(
                        mealType,
                        month,
                        year);
    }
}