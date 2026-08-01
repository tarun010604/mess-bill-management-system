package com.messbill.Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.Student;
import com.messbill.Service.StudentService;

@WebServlet("/editStudent")
public class EditStudentServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String studentIdStr = req.getParameter("studentId");

        try {
            Integer studentId = Integer.parseInt(studentIdStr);
            Student student = studentService.findStudentById(studentId);

            if (student == null) {
                resp.sendRedirect("viewStudents.jsp?msg=Student not found");
                return;
            }

            req.setAttribute("student", student);
            req.getRequestDispatcher("/editStudent.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("viewStudents.jsp?msg=Invalid student id");
        }
    }
}