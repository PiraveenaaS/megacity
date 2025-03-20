package com.megacity.controller.admin;

import com.megacity.model.DAO.DriverDAO;
import com.megacity.model.crud.*;
import org.json.JSONArray;
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
import java.util.List;

@WebServlet("/drivers/*")
public class Drivers extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"A".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/adminlogin");
            return;
        }
        String path = req.getPathInfo();

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        if (path == null || path.equals("/")) {
            req.getRequestDispatcher("/WEB-INF/drivers.jsp").forward(req, resp);
            return;
        }

        if (path.equals("/activedrivers")) {
            List<DriverDAO> allDrivers = GetData.getAllDrivers();
            JSONArray jsonArray = new JSONArray();

            for (DriverDAO driver : allDrivers) {
                JSONObject jsonDriver = new JSONObject();
                jsonDriver.put("driverId", driver.getDriverId());
                jsonDriver.put("firstName", driver.getFirstName());
                jsonDriver.put("lastName", driver.getLastName());
                jsonDriver.put("nicNumber", driver.getNicNumber());
                jsonDriver.put("licenseNumber", driver.getLicenseNumber());
                jsonDriver.put("phoneNumber", driver.getPhoneNumber());
                jsonDriver.put("email", driver.getEmail());
                jsonDriver.put("gender", driver.getGender());
                jsonDriver.put("dateOfBirth", driver.getDateOfBirth().toString());
                jsonDriver.put("address", driver.getAddress());
                jsonDriver.put("appointmentDate", driver.getAppointmentDate().toString());
                jsonDriver.put("currentStatus", driver.getCurrentStatus());
                jsonArray.put(jsonDriver);
            }

            resp.getWriter().write(jsonArray.toString());
        }
        else if (path.startsWith("/activedrivers/")) {
            String driverId = path.substring("/activedrivers/".length());
            if (driverId.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("status", "error");
                error.put("message", "Driver ID is required");
                resp.getWriter().write(error.toString());
                return;
            }

            String[] driverDetails = GetData.getDriverDetails(driverId);
            JSONObject jsonResponse = new JSONObject();

            if (driverDetails != null && driverDetails.length > 0) {
                jsonResponse.put("driverId", Integer.parseInt(driverDetails[0]));
                jsonResponse.put("firstName", driverDetails[1]);
                jsonResponse.put("lastName", driverDetails[2]);
                jsonResponse.put("nicNumber", driverDetails[3]);
                jsonResponse.put("licenseNumber", driverDetails[4]);
                jsonResponse.put("phoneNumber", driverDetails[5]);
                jsonResponse.put("email", driverDetails[6]);
                jsonResponse.put("gender", driverDetails[7]);
                jsonResponse.put("dateOfBirth", driverDetails[8]);
                jsonResponse.put("address", driverDetails[9]);
                jsonResponse.put("appointmentDate", driverDetails[10]);
                jsonResponse.put("currentStatus", driverDetails[11]);
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Driver not found");
            }

            resp.getWriter().write(jsonResponse.toString());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"A".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/adminlogin");
            return;
        }

        String path = req.getPathInfo();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        if (path.equals("/activedrivers")) {
            StringBuilder formData = new StringBuilder();
            String line;
            try (BufferedReader reader = req.getReader()) {
                while ((line = reader.readLine()) != null) {
                    formData.append(line);
                }
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("status", "error");
                error.put("message", "Error processing request: " + e.getMessage());
                out.write(error.toString());
                return;
            }

            JSONObject jsonObject = new JSONObject(formData.toString());
            JSONObject jsonResponse = new JSONObject();

            try {
                String firstName = jsonObject.getString("first_name");
                String lastName = jsonObject.getString("last_name");
                String nicNumber = jsonObject.getString("nic_number");
                String licenseNumber = jsonObject.getString("license_number");
                String phoneNumber = jsonObject.getString("phone_number");
                String email = jsonObject.getString("email");
                String gender = jsonObject.getString("gender");
                String dateOfBirth = jsonObject.getString("date_of_birth");
                String address = jsonObject.getString("address");
                String appointmentDate = jsonObject.getString("appointment_date");
                String currentStatus = jsonObject.getString("current_status");

                if (DataStore.storeDriverData(firstName, lastName, nicNumber, licenseNumber, phoneNumber,
                        email, gender, dateOfBirth, address, appointmentDate, currentStatus)) {
                    jsonResponse.put("status", "success");
                    jsonResponse.put("message", "Driver added successfully");
                } else {
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "Failed to add driver");
                }
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Invalid data format: " + e.getMessage());
            }

            out.write(jsonResponse.toString());
            out.flush();
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"A".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/adminlogin");
            return;
        }

        String path = req.getPathInfo();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        if (path != null && path.startsWith("/activedrivers/")) {
            String driverId = path.substring("/activedrivers/".length());
            if (driverId.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("status", "error");
                error.put("message", "Driver ID is required");
                out.write(error.toString());
                return;
            }

            StringBuilder formData = new StringBuilder();
            String line;
            try (BufferedReader reader = req.getReader()) {
                while ((line = reader.readLine()) != null) {
                    formData.append(line);
                }
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("status", "error");
                error.put("message", "Error processing request: " + e.getMessage());
                out.write(error.toString());
                return;
            }

            JSONObject jsonObject = new JSONObject(formData.toString());
            JSONObject jsonResponse = new JSONObject();

            try {
                String firstName = jsonObject.getString("first_name");
                String lastName = jsonObject.getString("last_name");
                String nicNumber = jsonObject.getString("nic_number");
                String licenseNumber = jsonObject.getString("license_number");
                String phoneNumber = jsonObject.getString("phone_number");
                String email = jsonObject.getString("email");
                String gender = jsonObject.getString("gender");
                String dateOfBirth = jsonObject.getString("date_of_birth");
                String address = jsonObject.getString("address");
                String appointmentDate = jsonObject.getString("appointment_date");
                String currentStatus = jsonObject.getString("current_status");

                if (UpdateData.updateDriverData(Integer.parseInt(driverId), Integer.parseInt(driverId), firstName, lastName,
                        nicNumber, licenseNumber, phoneNumber, email, gender, dateOfBirth, address, appointmentDate, currentStatus)) {
                    jsonResponse.put("status", "success");
                    jsonResponse.put("message", "Driver updated successfully");
                } else {
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "Failed to update driver");
                }
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Invalid data format: " + e.getMessage());
            }

            out.write(jsonResponse.toString());
            out.flush();
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || !"A".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/adminlogin");
            return;
        }

        String path = req.getPathInfo();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        if (path != null && path.startsWith("/activedrivers/")) {
            String driverId = path.substring("/activedrivers/".length());
            if (driverId.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject error = new JSONObject();
                error.put("status", "error");
                error.put("message", "Driver ID is required");
                out.write(error.toString());
                return;
            }

            String[] driverDetails = GetData.getDriverDetails(driverId);
            JSONObject jsonResponse = new JSONObject();

            if (driverDetails != null && driverDetails.length > 0) {
                if (DeleteData.deleteDriverData(driverId)) {
                    jsonResponse.put("status", "success");
                    jsonResponse.put("message", "Driver deleted successfully");
                }
                else {
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "Failed to delete driver");
                }
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Driver not found");
            }

            out.write(jsonResponse.toString());
            out.flush();
        }
    }
}