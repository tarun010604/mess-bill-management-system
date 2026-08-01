package com.messbill.Controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.Bill;
import com.messbill.Entity.PaymentSession;
import com.messbill.Entity.Student;
import com.messbill.Service.BillService;
import com.messbill.Service.EmailService;
import com.messbill.Service.PaymentSessionService;

@WebServlet("/generateBill")
public class BillServlet extends HttpServlet {

    private final BillService billService = new BillService();
    private final EmailService emailService = new EmailService();
    private final PaymentSessionService paymentSessionService = new PaymentSessionService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String studentIdStr = req.getParameter("studentId");
        String month = req.getParameter("month");
        String billYearStr = req.getParameter("billYear");

        try {
            if (studentIdStr == null || studentIdStr.trim().isEmpty()
                    || month == null || month.trim().isEmpty()
                    || billYearStr == null || billYearStr.trim().isEmpty()) {

                req.setAttribute("msg", "Please select student, month and year");
                req.getRequestDispatcher("/generateBill.jsp").forward(req, resp);
                return;
            }

            Integer studentId;
            Integer billYear;

            try {
                studentId = Integer.parseInt(studentIdStr);
                billYear = Integer.parseInt(billYearStr);
            } catch (NumberFormatException e) {
                req.setAttribute("msg", "Invalid student or year value");
                req.getRequestDispatcher("/generateBill.jsp").forward(req, resp);
                return;
            }

            Bill existingBill = billService.findBillByStudentAndMonth(studentId, month, billYear);
            if (existingBill != null) {
                req.setAttribute("msg", "Bill already generated for this student and month");
                req.getRequestDispatcher("/generateBill.jsp").forward(req, resp);
                return;
            }

            Bill bill = billService.generateBill(studentId, month, billYear);

            if (bill == null) {
                req.setAttribute("msg", "No attendance found for selected student and month");
                req.getRequestDispatcher("/generateBill.jsp").forward(req, resp);
                return;
            }

            Student student = bill.getStudent();
            if (student == null || student.getEmail() == null || student.getEmail().trim().isEmpty()) {
                req.setAttribute("msg", "Student email not found");
                req.getRequestDispatcher("/generateBill.jsp").forward(req, resp);
                return;
            }

            PaymentSession paymentSession = paymentSessionService.createSession(bill.getBillId());

            String paymentLink =
                    req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort()
                    + req.getContextPath()
                    + "/mockPayment?token="
                    + URLEncoder.encode(paymentSession.getToken(), StandardCharsets.UTF_8);

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MMM-yyyy");
            String formattedDueDate = bill.getDueDate() != null ? bill.getDueDate().format(formatter) : "N/A";

            String subject = "Mess Bill Notification - " + month + " " + billYear;

            String body =
                    "Dear " + student.getName() + ",\n\n"
                    + "Your mess bill has been generated successfully.\n\n"
                    + "Student Name   : " + student.getName() + "\n"
                    + "Roll No        : " + student.getRollNo() + "\n"
                    + "Department     : " + student.getDepartment() + "\n"
                    + "Month          : " + month + " " + billYear + "\n"
                    + "Breakfast Count: " + bill.getBreakfastCount() + "\n"
                    + "Lunch Count    : " + bill.getLunchCount() + "\n"
                    + "Dinner Count   : " + bill.getDinnerCount() + "\n"
                    + "Total Amount   : Rs. " + bill.getTotalAmount() + "\n"
                    + "Due Date       : " + formattedDueDate + "\n"
                    + "Status         : " + bill.getStatus() + "\n\n"
                    + "Payment Link:\n"
                    + paymentLink + "\n\n"
                    + "Regards,\n"
                    + "VIT Hostel Administration\n"
                    + "Visionary Institute of Technology";

            try {
                emailService.sendEmail(student.getEmail(), subject, body);
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("msg", "Bill generated, but email failed");
                req.getRequestDispatcher("/generateBill.jsp").forward(req, resp);
                return;
            }

            String successMessage = URLEncoder.encode(
                    "Bill generated and payment link emailed successfully",
                    StandardCharsets.UTF_8);

            resp.sendRedirect("generateBill.jsp?msg=" + successMessage);

        } catch (RuntimeException e) {
            req.setAttribute("msg", e.getMessage());
            req.getRequestDispatcher("/generateBill.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "Error while generating bill");
            req.getRequestDispatcher("/generateBill.jsp").forward(req, resp);
        }
    }
}