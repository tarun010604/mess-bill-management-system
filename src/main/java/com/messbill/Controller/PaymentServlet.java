package com.messbill.Controller;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.Bill;
import com.messbill.Entity.Payment;
import com.messbill.Service.BillService;
import com.messbill.Service.EmailService;
import com.messbill.Service.PaymentService;

@WebServlet("/payBill")
public class PaymentServlet extends HttpServlet {

    private final PaymentService paymentService = new PaymentService();
    private final BillService billService = new BillService();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String billIdStr = req.getParameter("billId");
        String paymentMethod = req.getParameter("paymentMethod");

        if (billIdStr == null || billIdStr.trim().isEmpty()
                || paymentMethod == null || paymentMethod.trim().isEmpty()) {

            req.setAttribute("msg", "Bill and payment method are required");
            req.getRequestDispatcher("payment.jsp?billId=" + billIdStr).forward(req, resp);
            return;
        }

        Integer billId;
        try {
            billId = Integer.parseInt(billIdStr);
        } catch (NumberFormatException e) {
            req.setAttribute("msg", "Invalid bill id");
            req.getRequestDispatcher("payment.jsp").forward(req, resp);
            return;
        }

        try {
            Payment payment = paymentService.markAsPaid(billId, paymentMethod, null);

            Bill bill = payment.getBill();
            if (bill == null || bill.getStudent() == null || bill.getStudent().getEmail() == null) {
                req.setAttribute("msg", "Payment completed, but student email not found");
                req.getRequestDispatcher("payment.jsp?billId=" + billId).forward(req, resp);
                return;
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MMM-yyyy");

            String subject = "Payment Successful - Mess Bill " + bill.getMonth() + " " + bill.getYear();

            String body =
                    "Dear " + bill.getStudent().getName() + ",\n\n"
                    + "Your mess bill payment has been completed successfully.\n\n"
                    + "Student Name   : " + bill.getStudent().getName() + "\n"
                    + "Roll No        : " + bill.getStudent().getRollNo() + "\n"
                    + "Month          : " + bill.getMonth() + " " + bill.getYear() + "\n"
                    + "Amount Paid    : Rs. " + payment.getAmount() + "\n"
                    + "Payment Date   : " + payment.getPaymentDate().format(formatter) + "\n"
                    + "Payment Method : " + payment.getPaymentMethod() + "\n"
                    + "Reference No   : " + payment.getReferenceNo() + "\n"
                    + "Status         : " + payment.getTransactionStatus() + "\n\n"
                    + "Regards,\n"
                    + "VIT Hostel Administration\n"
                    + "Visionary Institute of Technology";

            try {
                emailService.sendEmail(bill.getStudent().getEmail(), subject, body);
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("msg", "Payment completed, but email sending failed");
                req.getRequestDispatcher("payment.jsp?billId=" + billId).forward(req, resp);
                return;
            }

            String msg = URLEncoder.encode("Payment completed successfully", StandardCharsets.UTF_8);
            resp.sendRedirect("billDetails?billId=" + billId + "&msg=" + msg);

        } catch (RuntimeException e) {
            req.setAttribute("msg", e.getMessage());
            req.getRequestDispatcher("payment.jsp?billId=" + billId).forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "Error while processing payment");
            req.getRequestDispatcher("payment.jsp?billId=" + billId).forward(req, resp);
        }
    }
}