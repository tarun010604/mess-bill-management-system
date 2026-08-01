package com.messbill.Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.messbill.Service.AdminService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AdminService adminService = new AdminService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            req.setAttribute("msg", "Username and password are required");
            RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
            rd.forward(req, resp);
            return;
        }

        String result = adminService.validateLogin(username.trim(), password.trim());

        if ("SUCCESS".equalsIgnoreCase(result)) {
            HttpSession session = req.getSession();
            session.setAttribute("username", username);

            resp.sendRedirect("dashboard.jsp");
            return;
        }

        req.setAttribute("msg", result);
        RequestDispatcher rd = req.getRequestDispatcher("/login.jsp");
        rd.forward(req, resp);
    }
}