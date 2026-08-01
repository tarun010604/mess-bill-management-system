package com.messbill.Controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.Bill;
import com.messbill.Entity.PaymentSession;
import com.messbill.Service.BillService;
import com.messbill.Service.PaymentSessionService;

@WebServlet("/retryPayment")
public class RetryPaymentServlet extends HttpServlet {

    private final BillService billService = new BillService();
    private final PaymentSessionService paymentSessionService = new PaymentSessionService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String billIdStr = req.getParameter("billId");

        if (billIdStr == null || billIdStr.trim().isEmpty()) {
            req.setAttribute("msg", "Invalid bill id");
            req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
            return;
        }

        try {
            Integer billId = Integer.parseInt(billIdStr);

            Bill bill = billService.findBillById(billId);
            if (bill == null) {
                req.setAttribute("msg", "Bill not found");
                req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                return;
            }

            if ("Paid".equalsIgnoreCase(bill.getStatus())) {
                req.setAttribute("msg", "Bill already paid");
                req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
                return;
            }

            PaymentSession newSession = paymentSessionService.createSession(billId);

            String link = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort()
                    + req.getContextPath()
                    + "/mockPayment?token="
                    + URLEncoder.encode(newSession.getToken(), StandardCharsets.UTF_8);

            req.setAttribute("paymentLink", link);
            req.setAttribute("msg", "New payment link generated");
            req.getRequestDispatcher("/retryPayment.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("msg", "Unable to generate new payment link");
            req.getRequestDispatcher("/paymentError.jsp").forward(req, resp);
        }
    }
}