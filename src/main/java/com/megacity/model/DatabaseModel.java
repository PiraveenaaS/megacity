package com.megacity.model;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import com.megacity.service.DataBase;

public class DatabaseModel {
    static Connection conn = null;

    public static void createTable() {

        String createUserTable = "CREATE TABLE IF NOT EXISTS users ("
                + "email VARCHAR(100) UNIQUE NOT NULL PRIMARY KEY, "
                + "password VARCHAR(255) NOT NULL, "
                + "role ENUM('U', 'A') DEFAULT 'U' "
                + ");";

        String createUserDetailsTable = "CREATE TABLE IF NOT EXISTS user_details ("
                + "nic_number VARCHAR(12) UNIQUE NOT NULL PRIMARY KEY, "
                + "first_name VARCHAR(100) NOT NULL, "
                + "last_name VARCHAR(100) NOT NULL, "
                + "phone_number VARCHAR(10) NOT NULL, "
                + "email VARCHAR(100) NOT NULL, "
                + "address TEXT NOT NULL, "
                + "registration_date DATETIME DEFAULT CURRENT_TIMESTAMP"
                + ");";


        String createDriverDetailsTable = "CREATE TABLE IF NOT EXISTS drivers ("
                + "driver_id INT AUTO_INCREMENT PRIMARY KEY, "
                + "first_name VARCHAR(100) NOT NULL,"
                + "last_name VARCHAR(100) NOT NULL,"
                + "nic_number VARCHAR(12) UNIQUE NOT NULL,"
                + "license_number VARCHAR(15) UNIQUE NOT NULL, "
                + "phone_number VARCHAR(10) NOT NULL, "
                + "email VARCHAR(100) NOT NULL,"
                + "gender ENUM('male', 'female') NOT NULL,"
                + "date_of_birth DATE NOT NULL, "
                + "address TEXT NOT NULL, "
                + "appointment_date DATETIME NOT NULL, "
                + "current_status ENUM('Active', 'On Leave', 'half day', 'Terminated') NOT NULL "
                + ");";

        String createBookingsTable = "CREATE TABLE IF NOT EXISTS bookings ("
                + "booking_id INT AUTO_INCREMENT PRIMARY KEY, "
                + "source VARCHAR(255) NOT NULL, "
                + "destination VARCHAR(255) NOT NULL, "
                + "vehicle VARCHAR(20) NOT NULL, "
                + "need_ac TINYINT(1) NOT NULL, "
                + "travel_date DATE, "
                + "travel_time TIME, "
                + "total_fare DECIMAL(10, 2) NOT NULL, "
                + "nic_number VARCHAR(12) NOT NULL,"
                + "status ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending', "
                + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP "
                + ");";

        String createVehicleTable = "CREATE TABLE IF NOT EXISTS vehicles (" +
                "license_plate_number VARCHAR(35) UNIQUE NOT NULL, " +
                "vehicle_category VARCHAR(20) NOT NULL, " +
                "seat_capacity INT, " +
                "fuel_type VARCHAR(9) NOT NULL, " +
                "model VARCHAR(50), " +
                "status VARCHAR(11) NOT NULL, " +
                "buy_on DATE" +
                ")";

        try {
            conn = DataBase.getConnection();
            Statement stmt = conn.createStatement();


            stmt.executeUpdate(createUserTable);
            stmt.executeUpdate(createUserDetailsTable);
            stmt.executeUpdate(createBookingsTable);
            stmt.executeUpdate(createVehicleTable);
            stmt.executeUpdate(createDriverDetailsTable);

            System.out.println("Tables created successfully.");
        }
        catch (SQLException e) {
            System.err.println("DB Model ERROR: " + e.getMessage());
        }
    }

}
