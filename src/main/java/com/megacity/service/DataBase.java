package com.megacity.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBase {
    private static final String URL = "jdbc:mysql://localhost:3306/cab_db";
    private static final String USER = "root";
    private static final String PASSWORD = "root";
    private static Connection connection = null;

    private DataBase() {}

    public static Connection getConnection(){
        try{
            if (connection == null || connection.isClosed()){
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Database connected successfully.");
            }

        }
        catch (Exception e) {
            System.err.println("DB Connection ERROR: " + e.getMessage());
        }

        return connection;
    }

    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        }
        catch (SQLException e) {
            System.out.println("DB Connection Closed");
        }
    }
}