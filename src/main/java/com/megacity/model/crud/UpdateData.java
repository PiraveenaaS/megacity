package com.megacity.model.crud;

import com.megacity.service.DataBase;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class UpdateData {
    static Connection conn = null;

    public static boolean updateVehicleData(String originalLicensePlateNumber, String updatedLicensePlateNumber,
                                            String vehicleCategory, int seatCapacity, String fuelType,
                                            String model, String status, String buyOn) {
        String sql = "UPDATE vehicles SET license_plate_number = ?, vehicle_category = ?, seat_capacity = ?, " +
                "fuel_type = ?, model = ?, status = ?, buy_on = ? WHERE license_plate_number = ?";


        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, updatedLicensePlateNumber);
            statement.setString(2, vehicleCategory);
            statement.setInt(3, seatCapacity);
            statement.setString(4, fuelType);
            statement.setString(5, model);
            statement.setString(6, status);
            statement.setString(7, buyOn);
            statement.setString(8, originalLicensePlateNumber);

            int successful = statement.executeUpdate();
            return successful > 0;
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in updateVehicleData method: " + e.getMessage());
            return false;
        }
    }

    public static boolean updateDriverData(int originalDriverId, int updatedDriverId, String firstName, String lastName, String nicNumber, String licenseNumber, String phoneNumber, String email, String gender, String dateOfBirth, String address, String appointmentDate, String currentStatus) {
        String sql = "UPDATE drivers SET driver_id = ?, first_name = ?, last_name = ?, nic_number = ?, " +
                "license_number = ?, phone_number = ?, email = ?, gender = ?, date_of_birth = ?, " +
                "address = ?, appointment_date = ?, current_status = ? WHERE driver_id = ?";
        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setInt(1, updatedDriverId);
            statement.setString(2, firstName);
            statement.setString(3, lastName);
            statement.setString(4, nicNumber);
            statement.setString(5, licenseNumber);
            statement.setString(6, phoneNumber);
            statement.setString(7, email);
            statement.setString(8, gender);
            statement.setString(9, dateOfBirth);
            statement.setString(10, address);
            statement.setString(11, appointmentDate);
            statement.setString(12, currentStatus);
            statement.setInt(13, originalDriverId);

            int successful = statement.executeUpdate();
            return successful > 0;
        }
        catch (Exception e) {
            System.err.println("DB Model ERROR in updateDriverData method: " + e.getMessage());
            return false;
        }

    }
    public static boolean updateBookingStatus(String bookingId, String newStatus) {
        String sql = "UPDATE bookings SET status = ? WHERE booking_id = ?";
        try {
            conn = DataBase.getConnection();
            PreparedStatement statement = conn.prepareStatement(sql);

            statement.setString(1, newStatus);
            statement.setString(2, bookingId);

            int successful = statement.executeUpdate();
            return successful > 0;
        } catch (Exception e) {
            System.err.println("DB Model ERROR in updateBookingStatus method: " + e.getMessage());
            return false;
        }
    }
}
