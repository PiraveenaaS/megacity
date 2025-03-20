package com.megacity.controller.admin;

import com.megacity.model.crud.GetData;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/adminlogin")
public class AdminLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/adminlogin.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email").trim();
        String password = req.getParameter("password").trim();

        if (GetData.verifyAdmin(email, password, "A")) {
            req.getSession(true).setAttribute("role", "A");
            System.out.println("I am working");
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        }
        else {
            req.setAttribute("type", "fail");
            req.getRequestDispatcher("/WEB-INF/adminlogin.jsp").forward(req, resp);

        }

    }
}
