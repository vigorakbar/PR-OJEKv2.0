/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.ojekservice;

/**
 *
 * @author kingfalcon
 */
public class DriverAttribute {
    private int numberOfRating;
    private float averageRating;

    public DriverAttribute() {
    }

    public DriverAttribute(int numberOfRating, float averageRating) {
        this.numberOfRating = numberOfRating;
        this.averageRating = averageRating;
    }

    public int getNumberOfRating() {
        return numberOfRating;
    }

    public float getAverageRating() {
        return averageRating;
    }

    public void setNumberOfRating(int numberOfRating) {
        this.numberOfRating = numberOfRating;
    }

    public void setAverageRating(float averageRating) {
        this.averageRating = averageRating;
    }
    
    
}
