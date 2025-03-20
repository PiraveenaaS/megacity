package com.megacity.service;

import com.megacity.model.DatabaseModel;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


@WebListener
public class DataBaseStart implements ServletContextListener {
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Initializing Tables...");
        DatabaseModel.createTable();
        System.out.println("Initialized...");

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        DataBase.closeConnection();
        System.out.println("Shutting down Database...");
    }
}