package com.messbill.Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Service.StudentService;



@WebServlet("/updateStudentStatus")
public class StudentStatusServlet
        extends HttpServlet {

    private StudentService studentService =
            new StudentService();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException,
            IOException {

        String studentIdStr =
                req.getParameter(
                        "studentId");

        String status =
                req.getParameter(
                        "status");

        if(studentIdStr == null ||
           status == null){

            resp.sendRedirect(
                    "viewStudents.jsp");

            return;
        }

        Integer studentId =
                Integer.parseInt(
                        studentIdStr);

        studentService.updateStudentStatus(
                        studentId,
                        status);

        resp.sendRedirect(
                "viewStudents.jsp");
    }
}