package com.megacity.controller.admin;


import com.megacity.model.DAO.BookingDAO;
import com.megacity.model.crud.GetData;
import com.megacity.model.crud.UpdateData;
import com.megacity.service.Email;
import org.json.JSONArray;
import org.json.JSONObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard/*")
public class Dashboard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"A".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/adminlogin");
            return;
        }
        String path = req.getPathInfo();

        if (path == null) {
            req.getRequestDispatcher("/WEB-INF/dashboard.jsp").forward(req, resp);
        }
        else if (path.equals("/booking")) {
            List<BookingDAO> bookings = GetData.getRecentBookings();

            JSONArray jsonArray = new JSONArray();

            for (BookingDAO booking : bookings) {
                JSONObject jsonBooking = new JSONObject();
                jsonBooking.put("bookingID", booking.getBookingID());
                jsonBooking.put("customer", booking.getCustomer());
                jsonBooking.put("source", booking.getSource());
                jsonBooking.put("destination", booking.getDestination());
                jsonBooking.put("vehicle", booking.getVehicle());
                jsonBooking.put("needAC", booking.getNeedAC());
                jsonBooking.put("travelDate", booking.getTravelDate());
                jsonBooking.put("travelTime", booking.getTravelTime());
                jsonBooking.put("amount", booking.getAmount());
                jsonBooking.put("createdDate", booking.getCreatedDate());
                jsonBooking.put("status", booking.getStatus());
                jsonArray.put(jsonBooking);
            }

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonArray.toString());
        }
        else {
            System.err.println("The path is not found: " + path);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path != null && path.startsWith("/bookings/confirm/")) {
            String bookingId = path.substring("/bookings/confirm/".length());

            String[] bookingDetails = GetData.getBookingDetails(bookingId);
            String nicNumber = GetData.getNICFromBookingDetails(bookingId);
            String email = GetData.getEmailFromUserDetails(nicNumber);

            boolean success = UpdateData.updateBookingStatus(bookingId, "Confirmed");

            String message = "Booking Confirmed.\n Details are:\n" +
                    "Booking ID: " + bookingDetails[0] + "\n" +
                    "Customer: " + bookingDetails[1] + "\n" +
                    "Source: " + bookingDetails[2] + "\n" +
                    "Destination: " + bookingDetails[3] + "\n" +
                    "Vehicle: " + bookingDetails[4] + "\n" +
                    "Need AC: " + (Integer.parseInt(bookingDetails[5]) == 1 ? "Yes" : "No") + "\n" +
                    "Price: Rs" + String.format("%.2f", Double.parseDouble(bookingDetails[8]));


            boolean sendEmail = Email.sendEmail(email,"Booking Confirmation by Magacitycab", message);
            resp.setContentType("application/json");
            JSONObject responseJson = new JSONObject();

            if (success && sendEmail) {
                responseJson.put("success", true);
            }
            else {
                responseJson.put("success", false);
                responseJson.put("error", "Failed to confirm booking");
            }
            resp.getWriter().write(responseJson.toString());
        }
        else if (path != null && path.startsWith("/bookings/cancel/")) {
            String bookingId = path.substring("/bookings/cancel/".length());
            System.out.println(bookingId);

            String[] bookingDetails = GetData.getBookingDetails(bookingId);
            String nicNumber = GetData.getNICFromBookingDetails(bookingId);

            String email = GetData.getEmailFromUserDetails(nicNumber);

            boolean success = UpdateData.updateBookingStatus(bookingId, "Cancelled");

            String message = "\nBooking Cancelled. Due to some unavoidable Situation\nDetails are:\n" +
                    "Booking ID: " + bookingDetails[0] + "\n" +
                    "Customer: " + bookingDetails[1] + "\n" +
                    "Source: " + bookingDetails[2] + "\n" +
                    "Destination: " + bookingDetails[3] + "\n" +
                    "Vehicle: " + bookingDetails[4] + "\n" +
                    "Need AC: " + (Integer.parseInt(bookingDetails[5]) == 1 ? "Yes" : "No") + "\n";


            boolean sendEmail = Email.sendEmail(email,"Booking Cancellation by Magacitycab", message);
            resp.setContentType("application/json");
            JSONObject responseJson = new JSONObject();

            if (success && sendEmail) {
                responseJson.put("success", true);
            }
            else {
                responseJson.put("success", false);
                responseJson.put("error", "Failed to cancel booking");
            }
            resp.getWriter().write(responseJson.toString());
        }
        else {
            System.err.println("Invalid POST path: " + path);
        }

    }
}
