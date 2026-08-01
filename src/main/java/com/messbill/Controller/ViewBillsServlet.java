package com.messbill.Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.messbill.Entity.Bill;
import com.messbill.Service.BillService;

@WebServlet("/viewBills")
public class ViewBillsServlet extends HttpServlet {

    private BillService billService = new BillService();

   
   
    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword =
                req.getParameter("keyword");

        String month =
                req.getParameter("month");

        String yearStr =
                req.getParameter("year");

        String billStatus =
                req.getParameter("billStatus");

        String studentStatus =
                req.getParameter("studentStatus");

        Integer year = null;

        if(yearStr != null &&
           !yearStr.trim().isEmpty()) {

            year = Integer.parseInt(yearStr);
        }

        List<Bill> bills =
                billService.searchBills(
                        keyword,
                        month,
                        year,
                        billStatus,studentStatus);

        req.setAttribute("bills", bills);

        req.getRequestDispatcher(
                "viewBills.jsp")
                .forward(req, resp);
    }
}