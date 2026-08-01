package com.messbill.Controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.Attendance;
import com.messbill.Entity.Student;
import com.messbill.Service.AttendanceService;

@WebServlet("/saveAttendance")
public class AttendanceServlet extends HttpServlet {

    private AttendanceService attendanceService = new AttendanceService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String dateStr = req.getParameter("date");
        String mealType = req.getParameter("mealType");
        String year = req.getParameter("year");
        String[] studentIds = req.getParameterValues("studentId");

        String redirectUrl = "attendance.jsp";

        try {
            if (dateStr == null || dateStr.trim().isEmpty()
                    || mealType == null || mealType.trim().isEmpty()
                    || studentIds == null || studentIds.length == 0) {

                redirectUrl += "?msg=" + URLEncoder.encode("Please select date, meal and students", StandardCharsets.UTF_8);
                if (year != null && !year.trim().isEmpty()) {
                    redirectUrl += "&year=" + URLEncoder.encode(year, StandardCharsets.UTF_8);
                }
                resp.sendRedirect(redirectUrl);
                return;
            }

            LocalDate date = LocalDate.parse(dateStr);

            for (String idStr : studentIds) {
                Integer studentId = Integer.parseInt(idStr);

                boolean present = req.getParameter("present_" + studentId) != null;

                Student student = new Student();
                student.setStudentId(studentId);

                Attendance attendance = new Attendance();
                attendance.setDate(date);
                attendance.setMealType(mealType);
                attendance.setStatus(present ? "Present" : "Absent");
                attendance.setStudent(student);

                attendanceService.saveAttendance(attendance);
            }

            redirectUrl += "?msg=" + URLEncoder.encode("Attendance saved successfully", StandardCharsets.UTF_8);

            if (year != null && !year.trim().isEmpty()) {
                redirectUrl += "&year=" + URLEncoder.encode(year, StandardCharsets.UTF_8);
            }

            resp.sendRedirect(redirectUrl);

        } catch (RuntimeException e) {
            redirectUrl += "?msg=" + URLEncoder.encode(e.getMessage(), StandardCharsets.UTF_8);
            if (year != null && !year.trim().isEmpty()) {
                redirectUrl += "&year=" + URLEncoder.encode(year, StandardCharsets.UTF_8);
            }
            resp.sendRedirect(redirectUrl);

        } catch (Exception e) {
            redirectUrl += "?msg=" + URLEncoder.encode("Error while saving attendance", StandardCharsets.UTF_8);
            if (year != null && !year.trim().isEmpty()) {
                redirectUrl += "&year=" + URLEncoder.encode(year, StandardCharsets.UTF_8);
            }
            resp.sendRedirect(redirectUrl);
        }
    }
}