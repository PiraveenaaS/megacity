package com.megacity.model.crud;

import com.megacity.service.DataBase;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class DeleteData {
    static Connection conn = null;

    public static boolean deleteUserData(String email) {
        String sql = "DELETE FROM users WHERE email = ?";

        try {
            conn = DataBase.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
        catch (Exception e) {
            System.err.println("Error deleting Users: " + e.getMessage());
            return false;
        }
    }


    public static boolean deleteVehicleData(String licensePlateNumber) {
        String sql = "DELETE FROM vehicles WHERE license_plate_number = ?";

        try {
            conn = DataBase.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, licensePlateNumber);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
        catch (Exception e) {
            System.err.println("Error deleting vehicle: " + e.getMessage());
            return false;
        }
    }

    public static boolean deleteDriverData(String driverId) {
        String sql = "DELETE FROM drivers WHERE driver_id = ?";

        try {
            conn = DataBase.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, driverId);

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        }
        catch (Exception e) {
            System.err.println("Error deleting Drivers: " + e.getMessage());
            return false;
        }
    }
}
