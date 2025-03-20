package com.megacity.controller.user;

import com.megacity.model.crud.GetData;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class Login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email").trim();
        String password = req.getParameter("password").trim();

        if (GetData.verifyUser(email, password)) {
            String[] user = GetData.getUserDetails(email);

            HttpSession session = req.getSession(true);

            session.setAttribute("firstName", user[0]);
            session.setAttribute("lastName", user[1]);
            session.setAttribute("nic", user[2]);
            session.setAttribute("address", user[3]);
            session.setAttribute("phone", user[4]);
            session.setAttribute("email", user[5]);

            resp.sendRedirect(req.getContextPath() + "/bookride");
        }
        else {
            req.setAttribute("type", "fail");
            req.getRequestDispatcher("/WEB-INF/login.jsp").forward(req, resp);

        }

    }
}