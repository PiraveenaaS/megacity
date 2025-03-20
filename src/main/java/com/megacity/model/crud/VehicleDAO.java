package com.megacity.model.crud;

public class VehicleDAO {
    String licensePlateNumber;
    String vehicleCategory;
    int seatCapacity;
    String fuelType;
    String model;
    String status;
    String buyOn;

    public VehicleDAO(String licensePlateNumber, String vehicleCategory, int seatCapacity, String fuelType, String model, String status, String buyOn) {
        this.licensePlateNumber = licensePlateNumber;
        this.vehicleCategory = vehicleCategory;
        this.seatCapacity = seatCapacity;
        this.fuelType = fuelType;
        this.model = model;
        this.status = status;
        this.buyOn = buyOn;
    }

    public String getLicensePlateNumber() {
        return licensePlateNumber;
    }

    public void setLicensePlateNumber(String licensePlateNumber) {
        this.licensePlateNumber = licensePlateNumber;
    }

    public String getVehicleCategory() {
        return vehicleCategory;
    }

    public void setVehicleCategory(String vehicleCategory) {
        this.vehicleCategory = vehicleCategory;
    }

    public int getSeatCapacity() {
        return seatCapacity;
    }

    public void setSeatCapacity(int seatCapacity) {
        this.seatCapacity = seatCapacity;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBuyOn() {
        return buyOn;
    }

    public void setBuyOn(String buyOn) {
        this.buyOn = buyOn;
    }
}

