/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.ojekservice;

import java.sql.Timestamp;
import java.util.Date;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;
import javax.xml.bind.annotation.adapters.XmlAdapter;

/**
 *
 * @author kingfalcon
 */


@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "Order")
public class Order {
    @XmlElement(name = "id", required=true)
    private int id;
    @XmlElement(name = "userId", required=true)
    private int userId;
    @XmlElement(name = "driverId", required=true)
    private int driverId;
    @XmlJavaTypeAdapter(TimestampAdapter.class)
    private Timestamp timestamp;
    @XmlElement(name = "pickingpoint", required=true)
    private String pickingpoint;
    @XmlElement(name = "destination", required=true)
    private String destination;
    @XmlElement(name = "isComplete", required=true)
    private boolean isComplete;
    @XmlElement(name = "isVisibleByUser", required=true)
    private boolean isVisibleByUser;
    @XmlElement(name = "isVisibleByDriver", required=true)
    private boolean isVisibleByDriver;

    
    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public void setTimestamp(Timestamp timestamp) {
        this.timestamp = timestamp;
    }

    public void setPickingpoint(String pickingpoint) {
        this.pickingpoint = pickingpoint;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public void setIsComplete(boolean isComplete) {
        this.isComplete = isComplete;
    }

    public void setIsVisibleByUser(boolean isVisibleByUser) {
        this.isVisibleByUser = isVisibleByUser;
    }

    public void setIsVisibleByDriver(boolean isVisibleByDriver) {
        this.isVisibleByDriver = isVisibleByDriver;
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public int getDriverId() {
        return driverId;
    }

    public Timestamp getTimestamp() {
        return timestamp;
    }

    public String getPickingpoint() {
        return pickingpoint;
    }

    public String getDestination() {
        return destination;
    }

    public boolean isIsComplete() {
        return isComplete;
    }

    public boolean isIsVisibleByUser() {
        return isVisibleByUser;
    }

    public boolean isIsVisibleByDriver() {
        return isVisibleByDriver;
    }
    
    public Order() {
        
    }
    
    public Order(int id, int userId, int driverId, Timestamp timestamp, String pickingpoint, String destination, boolean isComplete, boolean isVisibleByUser, boolean isVisibleByDriver) {
        this.id = id;
        this.userId = userId;
        this.driverId = driverId;
        this.timestamp = timestamp;
        this.pickingpoint = pickingpoint;
        this.destination = destination;
        this.isComplete = isComplete;
        this.isVisibleByUser = isVisibleByUser;
        this.isVisibleByDriver = isVisibleByDriver;
    }
}
