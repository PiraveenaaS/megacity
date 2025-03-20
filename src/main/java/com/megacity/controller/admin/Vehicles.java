package com.megacity.controller.admin;

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

@WebServlet("/vehicles/*")
public class Vehicles extends HttpServlet {
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

        if (path == null) {
            req.getRequestDispatcher("/WEB-INF/vehicle.jsp").forward(req, resp);
        }
        else if (path.equals("/newvehicle")) {
            List<VehicleDAO> allVehicles = GetData.getAllVehicles();
            JSONArray jsonArray = new JSONArray();

            for (VehicleDAO vehicle : allVehicles) {
                JSONObject jsonVehicle = new JSONObject();
                jsonVehicle.put("licensePlate", vehicle.getLicensePlateNumber());
                jsonVehicle.put("vehicleCategory", vehicle.getVehicleCategory());
                jsonVehicle.put("seatCapacity", vehicle.getSeatCapacity());
                jsonVehicle.put("fuelType", vehicle.getFuelType());
                jsonVehicle.put("model", vehicle.getModel());
                jsonVehicle.put("status", vehicle.getStatus());
                jsonVehicle.put("buyOn", vehicle.getBuyOn());
                jsonArray.put(jsonVehicle);
            }

            resp.getWriter().write(jsonArray.toString());
        }
        else if (path.startsWith("/newvehicle/")) {
            String licensePlateNumber = path.substring("/newvehicle/".length());
            if (licensePlateNumber.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "License Plate Number is required");
                resp.getWriter().write(jsonResponse.toString());
                return;
            }

            String[] vehicleDetails = GetData.getVehicleDetails(licensePlateNumber);
            JSONObject jsonResponse = new JSONObject();

            if (vehicleDetails != null && vehicleDetails.length > 0) {
                jsonResponse.put("license_plate_number", vehicleDetails[0]);
                jsonResponse.put("vehicle_category", vehicleDetails[1]);
                jsonResponse.put("seat_capacity", Integer.parseInt(vehicleDetails[2]));
                jsonResponse.put("fuel_type", vehicleDetails[3]);
                jsonResponse.put("model", vehicleDetails[4]);
                jsonResponse.put("status", vehicleDetails[5]);
                jsonResponse.put("buy_on", vehicleDetails[6]);
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Vehicle not found");
            }

            resp.getWriter().write(jsonResponse.toString());
        }
        else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Invalid path");
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

        if (path != null && path.equals("/newvehicle")) {
            StringBuilder formData = new StringBuilder();
            String line;
            try (BufferedReader reader = req.getReader()) {
                while ((line = reader.readLine()) != null) {
                    formData.append(line);
                }
            } catch (Exception e) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Error reading request body: " + e.getMessage());
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }

            JSONObject jsonObject = new JSONObject(formData.toString());
            String licensePlateNumber = jsonObject.getString("license_plate_number");
            String vehicleCategory = jsonObject.getString("vehicle_category");
            int seatCapacity = jsonObject.getInt("seat_capacity");
            String fuelType = jsonObject.getString("fuel_type");
            String model = jsonObject.getString("model");
            String status = jsonObject.getString("status");
            String buyOn = jsonObject.getString("buy_on");

            JSONObject jsonResponse = new JSONObject();
            if (DataStore.storeVehicleData(licensePlateNumber, vehicleCategory, seatCapacity, fuelType, model, status, buyOn)) {
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "Vehicle Added Successfully");
            }
            else {
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Failed to add vehicle");
            }

            out.print(jsonResponse.toString());
            out.flush();
        }
        else {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Invalid path");
            out.print(jsonResponse.toString());
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

        if (path != null && path.startsWith("/newvehicle/")) {
            String licensePlateNumber = path.substring("/newvehicle/".length());
            if (licensePlateNumber.isEmpty()) {
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "License Plate Number is required");
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }

            JSONObject jsonResponse = new JSONObject();
            if (DeleteData.deleteVehicleData(licensePlateNumber)) {
                resp.setStatus(HttpServletResponse.SC_OK);
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "Vehicle Deleted Successfully");
            } else {
                resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Vehicle not found or could not be deleted");
            }

            out.print(jsonResponse.toString());
            out.flush();
        } else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Invalid path");
            out.print(jsonResponse.toString());
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

        if (path != null && path.startsWith("/newvehicle/")) {
            String licensePlateNumber = path.substring("/newvehicle/".length());
            if (licensePlateNumber.isEmpty()) {
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "License Plate Number is required");
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }

            StringBuilder formData = new StringBuilder();
            String line;
            try (BufferedReader reader = req.getReader()) {
                while ((line = reader.readLine()) != null) {
                    formData.append(line);
                }
            }
            catch (Exception e) {
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Error reading request body: " + e.getMessage());
                out.print(jsonResponse.toString());
                out.flush();
                return;
            }

            JSONObject jsonObject = new JSONObject(formData.toString());
            String updatedLicensePlateNumber = jsonObject.getString("license_plate_number");
            String vehicleCategory = jsonObject.getString("vehicle_category");
            int seatCapacity = jsonObject.getInt("seat_capacity");
            String fuelType = jsonObject.getString("fuel_type");
            String model = jsonObject.getString("model");
            String status = jsonObject.getString("status");
            String buyOn = jsonObject.getString("buy_on");

            JSONObject jsonResponse = new JSONObject();
            if (UpdateData.updateVehicleData(licensePlateNumber, updatedLicensePlateNumber, vehicleCategory, seatCapacity, fuelType, model, status, buyOn)) {
                resp.setStatus(HttpServletResponse.SC_OK);
                jsonResponse.put("status", "success");
                jsonResponse.put("message", "Vehicle Updated Successfully");
            }
            else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Failed to update vehicle");
            }

            out.print(jsonResponse.toString());
            out.flush();
        }
        else {
            System.err.println("Invalid Path");
        }
    }
}
