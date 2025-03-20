package com.megacity.model.DAO;

public class BookingDAO {
    private String bookingID;
    private String customer;
    private String source;
    private String destination;
    private String vehicle;
    private int needAC;
    private String travelDate;
    private String travelTime;
    private double amount;
    private String createdDate;
    private String status;

    public BookingDAO(String bookingID, String customer, String source, String destination, String vehicle, int needAC, String travelDate, String travelTime, double amount, String createdDate, String status) {
        this.bookingID = bookingID;
        this.customer = customer;
        this.source = source;
        this.destination = destination;
        this.vehicle = vehicle;
        this.needAC = needAC;
        this.travelDate = travelDate;
        this.travelTime = travelTime;
        this.amount = amount;
        this.createdDate = createdDate;
        this.status = status;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getVehicle() {
        return vehicle;
    }

    public void setVehicle(String vehicle) {
        this.vehicle = vehicle;
    }

    public int getNeedAC() {
        return needAC;
    }

    public void setNeedAC(int needAC) {
        this.needAC = needAC;
    }

    public String getTravelDate() {
        return travelDate;
    }

    public void setTravelDate(String travelDate) {
        this.travelDate = travelDate;
    }

    public String getTravelTime() {
        return travelTime;
    }

    public void setTravelTime(String travelTime) {
        this.travelTime = travelTime;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
