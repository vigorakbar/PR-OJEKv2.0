/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.grosheeran.ojekservice;

import java.sql.Timestamp;
import java.util.Date;
import javax.xml.bind.annotation.adapters.XmlAdapter;

/**
 *
 * @author kingfalcon
 */
public class TimestampAdapter extends XmlAdapter<Date, Timestamp> {
      public Date marshal(Timestamp v) {
          return new Date(v.getTime());
      }
      public Timestamp unmarshal(Date v) {
          return new Timestamp(v.getTime());
      }
  }