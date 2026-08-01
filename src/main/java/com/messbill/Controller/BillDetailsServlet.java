package com.messbill.Controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.Bill;
import com.messbill.Service.BillService;

@WebServlet("/billDetails")
public class BillDetailsServlet extends HttpServlet {

    private BillService billService = new BillService();

    @Override
   
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String billIdStr = req.getParameter("billId");
        String mode = req.getParameter("mode");

        if (billIdStr ==	 null || billIdStr.trim().isEmpty()) {
            resp.sendRedirect("viewBills.jsp");
            return;
        }

        Integer billId = Integer.parseInt(billIdStr);

        Bill bill = billService.findBillById(billId);

        if (bill == null) {
            resp.sendRedirect("viewBills.jsp?msg=Bill not found");
            return;
        }

        req.setAttribute("bill", bill);
        req.setAttribute("mode", mode);
        req.getRequestDispatcher("viewBillDetails.jsp").forward(req, resp);
    }
}