package com.megacity.controller.user;

import com.megacity.model.crud.DataStore;
import com.megacity.model.crud.DeleteData;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/signup")
public class Signup extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/signup.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String nic = req.getParameter("nic");
        String address = req.getParameter("address");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (DataStore.storeUser(email,password)) {
            if(DataStore.storeUserDetails(nic, firstName, lastName, phone, email, address)){
                HttpSession session = req.getSession(true);

                session.setAttribute("firstName", firstName);
                session.setAttribute("lastName", lastName);
                session.setAttribute("nic", nic);
                session.setAttribute("address", address);
                session.setAttribute("phone", phone);
                session.setAttribute("email", email);
                session.setAttribute("password", password);

                resp.sendRedirect(req.getContextPath() + "/bookride");
            }
            else{
                System.err.println("The User Details is not stored in Signup Page");
                DeleteData.deleteUserData(email);
            }
        }
        else {
            req.setAttribute("type", "fail");
            req.getRequestDispatcher("/WEB-INF/signup.jsp").forward(req, resp);
        }
    }
}
