package com.messbill.Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.Student;
import com.messbill.Service.StudentService;

@WebServlet("/updateStudent")
public class UpdateStudentServlet extends HttpServlet {

    private final StudentService studentService =
            new StudentService();

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)

            throws ServletException, IOException {

        try {

            Integer studentId =
                    Integer.parseInt(
                            req.getParameter(
                                    "studentId"));

            Student student =
                    studentService
                    .findStudentById(studentId);

            if(student == null){

                resp.sendRedirect(
                        "viewStudents.jsp?msg=Student not found");

                return;
            }

            String email =
                    req.getParameter("email");

            Long phone =
                    Long.parseLong(
                            req.getParameter("phone"));

            Long parentPhone =
                    Long.parseLong(
                            req.getParameter(
                                    "parentPhone"));

            student.setEmail(email);

            student.setPhone(phone);

            student.setParentPhone(parentPhone);

            studentService.updateStudent(student);

            resp.sendRedirect(
                    "viewStudents.jsp?msg=Student updated successfully");

        } catch(Exception e){

            e.printStackTrace();

            resp.sendRedirect(
                    "viewStudents.jsp?msg=Error while updating student");
        }
    }
}