package com.messbill.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;

import com.messbill.Entity.Student;
import com.messbill.Repository.StudentRepository;

import jakarta.persistence.Query;

import net.sf.ehcache.hibernate.HibernateUtil;


public class StudentService {

	
	private StudentRepository studentRepository=new StudentRepository();
	
	 public Map<String, String> saveStudent(Student s) {

	        Map<String, String> errors = new HashMap<>();

	        if (s.getName() == null || s.getName().trim().isEmpty()) {
	            errors.put("nameError", "Name is required");
	        }

	        if (s.getRollNo() == null || s.getRollNo().trim().isEmpty()) {
	            errors.put("rollNoError", "Roll No is required");
	        }

	        if (s.getEmail() == null || s.getEmail().trim().isEmpty()) {
	            errors.put("emailError", "Email is required");
	        }

	        if (s.getGender() == null || s.getGender().trim().isEmpty()) {
	            errors.put("genderError", "Gender is required");
	        }

	        if (s.getDepartment() == null || s.getDepartment().trim().isEmpty()) {
	            errors.put("departmentError", "Department is required");
	        }

	        if (s.getYear() == null || s.getYear().trim().isEmpty()) {
	            errors.put("yearError", "Year is required");
	        }

	        if (s.getHostelRoomNo() == null || s.getHostelRoomNo().trim().isEmpty()) {
	            errors.put("hostelRoomNoError", "Hostel Room No is required");
	        }

	        if (s.getStatus() == null || s.getStatus().trim().isEmpty()) {
	            errors.put("statusError", "Status is required");
	        }

	        if (s.getPhone() == null) {
	            errors.put("phoneError", "Phone is required");
	        } else if (String.valueOf(s.getPhone()).length() != 10) {
	            errors.put("phoneError", "Phone must contain 10 digits");
	        }

	        if (s.getParentPhone() == null) {
	            errors.put("parentPhoneError", "Parent Phone is required");
	        } else if (String.valueOf(s.getParentPhone()).length() != 10) {
	            errors.put("parentPhoneError", " Phone must contain 10 digits");
	        }

	        if (!errors.isEmpty()) {
	            return errors;
	        }

	        studentRepository.saveStudent(s);
	        
	        ActivityService activityService = new ActivityService();
	        activityService.saveActivity("Student Added", "Success");

	        return errors;
	    }
	 
	 public List<Student> getAllStudents(){
		 
		 return studentRepository.getAllStudents();
	 }
	 public List<Student> getStudentsByYear(String year) {
		    return studentRepository.getStudentsByYear(year);
		}
	 
	 public List<Student> searchStudents(String year, String department, String rollNo, String name, String hostelRoomNo) {
	        return studentRepository.searchStudents(year, department, rollNo, name, hostelRoomNo);
	    }
	 
	 public Student findById(Integer studentId) {
		    return studentRepository.findById(studentId);
		}
	 
	 public Long getTotalStudentsCount() {
		    return studentRepository.countAllStudents();
		}

		public Long getActiveStudentsCount() {
		    return studentRepository.countActiveStudents();
		}
		
		public Long getStudentsCountByYear(
		        String year) {

		    return studentRepository
		            .countStudentsByYear(year);
		}	
		
		public Long getStudentsCountByDepartment(
		        String department) {

		    return studentRepository
		            .countStudentsByDepartment(
		                    department);
		}
		
		public Long getInactiveStudentsCount() {
		    return studentRepository.countInactiveStudents();
		}
		
		public void updateStudentStatus(
		        Integer studentId,
		        String status) {

		    studentRepository
		            .updateStudentStatus(
		                    studentId,
		                    status);
		}
		
		public java.util.List<Student> getActiveStudents() {
		    return studentRepository.getActiveStudents();
		}

		public java.util.List<Student> getActiveStudentsByYear(String year) {
		    return studentRepository.getActiveStudentsByYear(year);
		}
		
		

		public List<Student> searchActiveStudents(String year, String department, String rollNo, String name, String hostelRoomNo) {
		    return studentRepository.searchActiveStudents(year, department, rollNo, name, hostelRoomNo);
		}
		
		public Student findStudentById(Integer studentId) {
		    return studentRepository.findStudentById(studentId);
		}

		public void updateStudent(Student student) {
		    studentRepository.updateStudent(student);
		}
		
			
}
