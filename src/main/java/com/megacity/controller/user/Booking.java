package com.megacity.controller.user;

import com.megacity.model.crud.DataStore;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/bookride")
public class Booking extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/booking.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = req.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (Exception e) {
            System.err.println("Booking Riding ERROR in json request gathering: " + e.getMessage());
            e.printStackTrace();
        }
        // Parse JSON request
        JSONObject requestJson = new JSONObject(sb.toString());


        // Extract booking data
        JSONObject json = new JSONObject(sb.toString());
        String source = json.getString("source");
        String destination = json.getString("destination");
        String vehicle = json.getString("vehicle");
        boolean needAC = json.getBoolean("needAC");
        String travelDate = json.getString("travelDate");
        String travelTime = json.getString("travelTime");
        double totalFare = json.getDouble("totalFare");
        String nicNumber = (String) req.getSession(false).getAttribute("nic");

        // Save to database
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();

        JSONObject responseJson = new JSONObject();
        if (nicNumber != null && DataStore.storeBookingDetails(source, destination, vehicle, needAC, travelDate, travelTime, totalFare, nicNumber)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            responseJson.put("success", true);
            responseJson.put("message", "Booking is stored Confirmation will be by Email");
        }
        else {
            responseJson.put("success", false);
            responseJson.put("message", "Error confirming booking. Please try again.");

        }
        out.write(responseJson.toString());
        out.flush();
    }
}