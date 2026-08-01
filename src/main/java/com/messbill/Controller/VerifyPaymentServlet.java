package com.messbill.Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.Bill;
import com.messbill.Entity.Payment;
import com.messbill.Entity.PaymentSession;
import com.messbill.Service.EmailService;
import com.messbill.Service.PaymentSessionService;
import com.messbill.Service.PaymentService;

@WebServlet("/verifyPayment")
public class VerifyPaymentServlet extends HttpServlet {

    private final PaymentSessionService paymentSessionService = new PaymentSessionService();
    private final PaymentService paymentService = new PaymentService();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String token = req.getParameter("token");
        String amountStr = req.getParameter("amount");
        String paymentMethod = req.getParameter("paymentMethod");
        String otp = req.getParameter("otp");

        try {
            if (token == null || token.trim().isEmpty()
                    || amountStr == null || amountStr.trim().isEmpty()
                    || paymentMethod == null || paymentMethod.trim().isEmpty()
                    || otp == null || otp.trim().isEmpty()) {

                req.setAttribute("msg", "All payment fields are required");
                req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                return;
            }

            PaymentSession session = paymentSessionService.findByToken(token);

            if (session == null) {
                req.setAttribute("msg", "Invalid payment session");
                req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                return;
            }

            if (session.isUsed()) {
                req.setAttribute("msg", "This payment session is already used");
                req.setAttribute("billId", session.getBill().getBillId());
                req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                return;
            }

            if (LocalDate.now().isAfter(session.getExpiresAt().toLocalDate())) {
                req.setAttribute("msg", "Session expired, try again later");
                req.setAttribute("billId", session.getBill().getBillId());
                req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                return;
            }

            if (!paymentSessionService.verifyOtp(session, otp)) {
                req.setAttribute("msg", "Invalid OTP");
                req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                return;
            }

            Bill bill = session.getBill();
            if (bill == null) {
                req.setAttribute("msg", "Bill not found");
                req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                return;
            }

            double enteredAmount;
            try {
                enteredAmount = Double.parseDouble(amountStr);
            } catch (NumberFormatException e) {
                req.setAttribute("msg", "Invalid amount");
                req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                return;
            }

            double expectedAmount = paymentService.calculatePayableAmount(bill);

            if (Double.compare(enteredAmount, expectedAmount) != 0) {
                req.setAttribute("msg", "Entered amount does not match bill amount with late fee");
                req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                return;
            }

            Payment payment = paymentService.markAsPaid(
                    bill.getBillId(),
                    paymentMethod,
                    null
            );

            paymentSessionService.markUsed(session);

            if (bill.getStudent() != null && bill.getStudent().getEmail() != null) {
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MMM-yyyy");

                String subject = "Payment Successful - Mess Bill " + bill.getMonth() + " " + bill.getYear();

                String body =
                        "Dear " + bill.getStudent().getName() + ",\n\n"
                        + "Your mess bill payment has been completed successfully.\n\n"
                        + "Student Name   : " + bill.getStudent().getName() + "\n"
                        + "Roll No        : " + bill.getStudent().getRollNo() + "\n"
                        + "Month          : " + bill.getMonth() + " " + bill.getYear() + "\n"
                        + "Bill Amount    : Rs. " + bill.getTotalAmount() + "\n"
                        + "Late Fee       : Rs. " + payment.getLateFee() + "\n"
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
                    req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                    return;
                }
            }

            req.setAttribute("bill", bill);
            req.setAttribute("payment", payment);
            req.getRequestDispatcher("/paymentSuccess.jsp").forward(req, resp);

        } catch (RuntimeException e) {
            req.setAttribute("msg", e.getMessage());
            req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "Error while verifying payment");
            req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
        }
    }
}