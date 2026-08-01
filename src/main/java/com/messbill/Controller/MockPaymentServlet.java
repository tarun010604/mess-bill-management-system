package com.messbill.Controller;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.PaymentSession;
import com.messbill.Service.EmailService;
import com.messbill.Service.PaymentSessionService;

@WebServlet("/mockPayment")
public class MockPaymentServlet extends HttpServlet {

    private PaymentSessionService paymentSessionService =
            new PaymentSessionService();
    
    

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    	
    	resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    	resp.setHeader("Pragma", "no-cache");
    	resp.setDateHeader("Expires", 0);

        String token = req.getParameter("token");

        if (token == null || token.trim().isEmpty()) {
            req.setAttribute("msg", "Invalid payment link");
            req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
            return;
        }

        PaymentSession session = paymentSessionService.findByToken(token);

        if (session == null) {
            req.setAttribute("msg", "Payment session not found");
            req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
            return;
        }

        if (session.isUsed()) {
            req.setAttribute("msg", "This payment session is already used");
            req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
            return;
        }

        if (LocalDateTime.now().isAfter(session.getExpiresAt())) {
            req.setAttribute("msg", "Session expired. Try again later");
            

            req.setAttribute(
                    "billId",
                    session.getBill().getBillId());
            req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
            return;
        }

        if ("Paid".equalsIgnoreCase(session.getBill().getStatus())) {
            req.setAttribute("msg", "Bill already paid");
            req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
            return;
        }
        
        if(session.getBill().getDueDate() != null &&
        		   java.time.LocalDate.now()
        		   .isAfter(session.getBill().getDueDate())) {

        		    double billAmount =
        		            session.getBill().getTotalAmount();

        		    double lateFee = 100.0;

        		    double totalPayable =
        		            billAmount + lateFee;

        		    String paymentLink =
        		            req.getScheme() + "://"
        		            + req.getServerName()
        		            + ":"
        		            + req.getServerPort()
        		            + req.getContextPath()
        		            + "/mockPayment?token="
        		            + session.getToken();

        		    EmailService emailService =
        		            new EmailService();

        		    try {

        		        emailService.sendLateFeeReminder(
        		                session.getBill()
        		                .getStudent()
        		                .getEmail(),

        		                session.getBill()
        		                .getStudent()
        		                .getName(),

        		                session.getBill()
        		                .getMonth(),

        		                session.getBill()
        		                .getYear(),

        		                billAmount,

        		                lateFee,

        		                totalPayable,

        		                paymentLink);

        		    } catch(Exception e) {

        		        e.printStackTrace();
        		    }
        		}

        req.setAttribute("paymentSession", session);
        req.getRequestDispatcher("/mockPayment.jsp").forward(req, resp);
    }
}