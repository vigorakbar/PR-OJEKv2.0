/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.identityservice.model;

/**
 *
 * @author kingfalcon
 */
public class User {
    private int userId;
    private String username;
    private String name;
    private String email;
    private String phoneNumber;
    private int driver;
    private String image;

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setDriver(int driver) {
        this.driver = driver;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public int getDriver() {
        return driver;
    }

    public String getImage() {
        return image;
    }
    
    public User() {
        
    }
    public User(int userId, String username, String name, String email, String phoneNumber, int driver, String image) {
        this.userId = userId;
        this.username = username;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.driver = driver;
        this.image = image;
    }
}
