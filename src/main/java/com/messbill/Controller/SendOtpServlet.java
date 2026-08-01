package com.messbill.Controller;

import java.io.IOException;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.PaymentSession;
import com.messbill.Service.EmailService;
import com.messbill.Service.PaymentSessionService;

@WebServlet("/sendOtp")
public class SendOtpServlet extends HttpServlet {

    private final PaymentSessionService paymentSessionService = new PaymentSessionService();
    private final EmailService emailService = new EmailService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String token = req.getParameter("token");

        try {
            PaymentSession session = paymentSessionService.findByToken(token);

            if (session == null) {
                req.setAttribute("msg", "Invalid payment session");
                req.getRequestDispatcher("paymentError.jsp").forward(req, resp);
                return;
            }

            if (session.isUsed()) {
                req.setAttribute("msg", "This payment session is already used");
                req.getRequestDispatcher("paymentError.jsp").forward(req, resp);
                return;
            }

            if (java.time.LocalDateTime.now().isAfter(session.getExpiresAt())) {
                req.setAttribute("msg", "Session expired, try again later");
                req.getRequestDispatcher("paymentError.jsp").forward(req, resp);
                return;
            }

            String email = session.getBill().getStudent().getEmail();
            String otp = session.getOtp();

            String subject = "Your OTP for Mess Bill Payment";
            String body =
                    "Dear " + session.getBill().getStudent().getName() + ",\n\n"
                    + "Your OTP for payment verification is: " + otp + "\n\n"
                    
                    + "Regards,\n"
                    + "VIT Hostel Administration";

            emailService.sendEmail(email, subject, body);

            req.setAttribute("msg", "OTP sent to your email");
            req.setAttribute("paymentSession", session);
            req.getRequestDispatcher("mockPayment.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "Unable to send OTP");
            req.getRequestDispatcher("paymentError.jsp").forward(req, resp);
        }
    }
}