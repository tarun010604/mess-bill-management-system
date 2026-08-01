package com.messbill.Controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.Student;
import com.messbill.Service.StudentService;

@WebServlet("/addstudent")
public class AddStudentServlet  extends HttpServlet{
	
	private StudentService studentService=new StudentService();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
	   
		String name=req.getParameter("name");
		String rollNo=req.getParameter("rollNo");
		String department=req.getParameter("department");
		String phoneStr=req.getParameter("phone");
		String parentPhoneStr=req.getParameter("parentPhone");
	
		String email=req.getParameter("email");
		String year=req.getParameter("year");
		String hostelRoomNo=req.getParameter("hostelRoomNo");
		String status=req.getParameter("status");
		String gender=req.getParameter("gender");
		

           Long phone = null;
           Long parentPhone = null;

            if (phoneStr != null && !phoneStr.trim().isEmpty()) {
                 phone = Long.parseLong(phoneStr);
            }

          if (parentPhoneStr != null && !parentPhoneStr.trim().isEmpty()) {
             parentPhone = Long.parseLong(parentPhoneStr);
      }
 		
		
		Student s=new Student();
		
		s.setName(name);
		s.setDepartment(department);
		s.setEmail(email);
		s.setHostelRoomNo(hostelRoomNo);
		s.setParentPhone(parentPhone);
		s.setPhone(phone);
		s.setRollNo(rollNo);
		s.setStatus(status);
		s.setYear(year);
		s.setGender(gender);
		
		

        Map<String, String> errors = studentService.saveStudent(s);

        if (!errors.isEmpty()) {
            for (Map.Entry<String, String> entry : errors.entrySet()) {
                req.setAttribute(entry.getKey(), entry.getValue());
            }
            RequestDispatcher rd = req.getRequestDispatcher("addStudent.jsp");
            rd.forward(req, resp);
            return;
        }

        resp.sendRedirect("dashboard.jsp");
		
		
		
		
	}
}
