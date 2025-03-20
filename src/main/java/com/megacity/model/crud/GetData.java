package com.megacity.model.crud;

import com.megacity.model.DAO.BookingDAO;
import com.megacity.model.DAO.DriverDAO;
import com.megacity.service.DataBase;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GetData {
    static Connection conn = null;

    public static boolean verifyUser(String email, String passWord) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ? AND password = ?";

        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, email.trim());
            statement.setString(2, passWord.trim());

            ResultSet result = statement.executeQuery();
            result.next();
            result.getInt(1);

            return result.getInt(1) == 1;

        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in verifyUser method: " + e.getMessage());
            return false;
        }
    }
    public static String[] getUserDetails(String email) {
        String sql = "SELECT * FROM user_details WHERE email = ?";
        String[] user = null;

        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, email);

            ResultSet result = statement.executeQuery();
            result.next();

            user = new String[6];
            user[0] = result.getString("first_name");
            user[1] = result.getString("last_name");
            user[2] = result.getString("nic_number");
            user[3] = result.getString("address");
            user[4] = result.getString("phone_number");
            user[5] = result.getString("email");
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in getUserDetails method: " + e.getMessage());
        }
        return user;
    }

    public static boolean verifyAdmin(String email, String password, String role) {
        String sql = "SELECT COUNT(*) FROM users WHERE email = ? AND password = ? AND role = ?";
        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, email.trim());
            statement.setString(2, password.trim());
            statement.setString(3, "A");

            ResultSet result = statement.executeQuery();
            result.next();
            result.getInt(1);

            return result.getInt(1) == 1;

        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in verifyAdmin method: " + e.getMessage());
            return false;
        }

    }
    public static List<BookingDAO> getRecentBookings() {
        String sql = "SELECT b.*, CONCAT(u.first_name, ' ', u.last_name) AS customer_name " +
                "FROM bookings b " +
                "LEFT JOIN user_details u ON b.nic_number = u.nic_number " +
                "ORDER BY b.created_at DESC";

        List<BookingDAO> bookings = new ArrayList<>();

        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet result = statement.executeQuery();

            while(result.next()) {
                BookingDAO booking = new BookingDAO(
                        result.getString("booking_id"),
                        result.getString("customer_name"),
                        result.getString("source"),
                        result.getString("destination"),
                        result.getString("vehicle"),
                        result.getInt("need_ac"),
                        result.getString("travel_date"),
                        result.getString("travel_time"),
                        result.getDouble("total_fare"),
                        result.getString("created_at"),
                        result.getString("status")
                );
                bookings.add(booking);
            }
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in getRecentBookings method: " + e.getMessage());
        }

        return bookings;
    }
    public static String[] getBookingDetails(String bookingId) {
        String sql = "SELECT b.*, CONCAT(u.first_name, ' ', u.last_name) AS customer_name " +
                "FROM bookings b " +
                "LEFT JOIN user_details u ON b.nic_number = u.nic_number " +
                "WHERE b.booking_id = ?";
        String[] booking = null;

        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, bookingId.trim());

            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    booking = new String[11];
                    booking[0] = result.getString("booking_id");
                    booking[1] = result.getString("customer_name");
                    booking[2] = result.getString("source");
                    booking[3] = result.getString("destination");
                    booking[4] = result.getString("vehicle");
                    booking[5] = String.valueOf(result.getInt("need_ac"));
                    booking[6] = result.getString("travel_date");
                    booking[7] = result.getString("travel_time");
                    booking[8] = String.valueOf(result.getDouble("total_fare"));
                    booking[9] = result.getString("created_at");
                    booking[10] = result.getString("status");
                }
            }
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in getBookingDetails method: " + e.getMessage());
        }
        return booking;
    }
    public static String getNICFromBookingDetails(String bookingId) {
        String sql = "SELECT nic_number FROM bookings WHERE booking_id = ?";
        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, bookingId.trim());

            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    return result.getString("nic_number");
                }
            }
        } catch (Exception e) {
            System.err.println("DB Model ERROR in getNICFromBookingDetails method: " + e.getMessage());
        }

        return null;
    }

    public static String getEmailFromUserDetails(String Nic) {
        String sql = "SELECT email FROM user_details WHERE nic_number = ?";
        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, Nic.trim());

            try (ResultSet result = statement.executeQuery()) {
                if (result.next()) {
                    return result.getString("email");
                }
            }
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in getEmailFromUserDetails method: " + e.getMessage());
        }

        return null;
    }
    public static String[] getVehicleDetails(String licensePlateNumber) {
        String sql = "SELECT * FROM vehicles WHERE license_plate_number = ?";
        String[] vehicle = null;

        try {
            Connection conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, licensePlateNumber.trim());

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                vehicle = new String[7];
                vehicle[0] = result.getString("license_plate_number");
                vehicle[1] = result.getString("vehicle_category");
                vehicle[2] = String.valueOf(result.getInt("seat_capacity"));
                vehicle[3] = result.getString("fuel_type");
                vehicle[4] = result.getString("model");
                vehicle[5] = result.getString("status");
                vehicle[6] = result.getString("buy_on");
            }
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in getVehicleDetails method: " + e.getMessage());
        }
        return vehicle;
    }

    public static List<VehicleDAO> getAllVehicles() {
        String sql = "SELECT * FROM vehicles";

        List<VehicleDAO> vehicles = new ArrayList<>();
        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                VehicleDAO vehicle = new VehicleDAO(
                        result.getString("license_plate_number"),
                        result.getString("vehicle_category"),
                        result.getInt("seat_capacity"),
                        result.getString("fuel_type"),
                        result.getString("model"),
                        result.getString("status"),
                        result.getString("buy_on")
                );
                vehicles.add(vehicle);
            }
        } catch (Exception e) {
            System.err.println("DB Model ERROR in getAllVehicles method: " + e.getMessage());
        }
        return vehicles;
    }

    public static List<DriverDAO> getAllDrivers() {
        String sql = "SELECT * FROM drivers";

        List<DriverDAO> drivers = new ArrayList<>();
        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            ResultSet result = statement.executeQuery();

            while (result.next()) {
                DriverDAO driver = new DriverDAO(
                        result.getInt("driver_id"),
                        result.getString("first_name"),
                        result.getString("last_name"),
                        result.getString("nic_number"),
                        result.getString("license_number"),
                        result.getString("phone_number"),
                        result.getString("email"),
                        result.getString("gender"),
                        result.getString("date_of_birth"),
                        result.getString("address"),
                        result.getString("appointment_date"),
                        result.getString("current_status")
                );
                drivers.add(driver);
            }
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in getAllDrivers method: " + e.getMessage());
        }
        return drivers;
    }

    public static String[] getDriverDetails(String driverId) {
        String sql = "SELECT * FROM drivers WHERE driver_id = ?";
        String[] driver = null;

        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, driverId.trim());

            ResultSet result = statement.executeQuery();

            if (result.next()) {
                driver = new String[12];
                driver[0] = String.valueOf(result.getInt("driver_id"));
                driver[1] = result.getString("first_name");
                driver[2] = result.getString("last_name");
                driver[3] = result.getString("nic_number");
                driver[4] = result.getString("license_number");
                driver[5] = result.getString("phone_number");
                driver[6] = result.getString("email");
                driver[7] = result.getString("gender");
                driver[8] = result.getDate("date_of_birth").toString();
                driver[9] = result.getString("address");
                driver[10] = result.getTimestamp("appointment_date").toString();
                driver[11] = result.getString("current_status");
            }
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in getDriverDetails method: " + e.getMessage());
        }

        return driver;
    }


}
