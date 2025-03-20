package com.megacity.model.crud;

import com.megacity.service.DataBase;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class DataStore {
    static Connection conn = null;

    public static boolean storeUser(String email, String password) {
        String sql = "INSERT INTO users (email, password) VALUES (?, ?)";
        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, email);
            statement.setString(2, password);

            int successful = statement.executeUpdate();
            return successful > 0;
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in storeUser method: " + e.getMessage());
            return false;
        }
    }

    public static boolean storeUserDetails(String nic, String firstName, String lastName, String phoneNumber, String email, String address) {
        String sql = "INSERT INTO user_details (nic_number, first_name, last_name, phone_number, email, address) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, nic);
            statement.setString(2, firstName);
            statement.setString(3, lastName);
            statement.setString(4, phoneNumber);
            statement.setString(5, email);
            statement.setString(6, address);

            int successful = statement.executeUpdate();
            return successful > 0;
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in storeUserDetails method: " + e.getMessage());
            return false;
        }
    }

    public static boolean storeBookingDetails(String source, String destination, String vehicle, boolean needAC, String travelDate, String travelTime, double totalFare, String nicNumber) {
        String sql = "INSERT INTO bookings (source, destination, vehicle, need_ac, " +
                "travel_date, travel_time, total_fare, nic_number) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);


            statement.setString(1, source);
            statement.setString(2, destination);
            statement.setString(3, vehicle);
            statement.setBoolean(4, needAC);
            statement.setString(5, travelDate);
            statement.setString(6, travelTime);
            statement.setDouble(7, totalFare);
            statement.setString(8, nicNumber);

            int successful = statement.executeUpdate();
            return successful > 0;
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in storeBookingDetails method: " + e.getMessage());
            return false;
        }
    }

    public static boolean storeVehicleData(String licensePlateNumber, String vehicleCategory, int seatCapacity, String fuelType, String model, String status, String buyOn) {
        String sql = "INSERT INTO vehicles (license_plate_number, vehicle_category, seat_capacity, fuel_type, model, status, buy_on) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, licensePlateNumber.trim());
            statement.setString(2, vehicleCategory);
            statement.setInt(3, seatCapacity);
            statement.setString(4, fuelType);
            statement.setString(5, model);
            statement.setString(6, status);
            statement.setString(7, buyOn);

            int successful = statement.executeUpdate();
            return successful > 0;
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in storeVehicleData method: " + e.getMessage());
            return false;
        }
    }
    public static boolean storeDriverData(String firstName, String lastName, String nicNumber, String licenseNumber, String phoneNumber, String email, String gender, String dateOfBirth, String address, String appointmentDate, String currentStatus) {
        String sql = "INSERT INTO drivers (first_name, last_name, nic_number, license_number, " +
                "phone_number, email, gender, date_of_birth, address, appointment_date, current_status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, firstName.trim());
            statement.setString(2, lastName.trim());
            statement.setString(3, nicNumber.trim());
            statement.setString(4, licenseNumber.trim());
            statement.setString(5, phoneNumber.trim());
            statement.setString(6, email.trim());
            statement.setString(7, gender);
            statement.setString(8, dateOfBirth);
            statement.setString(9, address);
            statement.setString(10, appointmentDate);
            statement.setString(11, currentStatus);

            int successful = statement.executeUpdate();
            return successful > 0;
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in storeDriverData method: " + e.getMessage());
            return false;
        }

    }

}
