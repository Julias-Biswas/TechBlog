/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techblog.entities;

import java.sql.Timestamp;

/**
 *
 * @author julia
 */
public class User 
{
    private int id;
    private String name;
    private String email;
    private String password;
    private String gender;
    private String aboutUser;
    private Timestamp dateTime;
    private String profileImg;

    public User()
    {
        
    }

    public User(String email)
    {
        this.email = email;
    }
    
    public User(String name, String email, String gender, String profileImg)
    {
        this.name = name;
        this.email = email;
        this.gender = gender;
        this.profileImg = profileImg;
    }

    public User(String name, String email, String gender, Timestamp dateTime, String profileImg)
    {
        this.name = name;
        this.email = email;
        this.gender = gender;
        this.dateTime = dateTime;
        this.profileImg = profileImg;
    }
    
    public User(String name, String email, String password, String gender, String aboutUser) 
    {
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.aboutUser = aboutUser;
    }

    public User(String name, String email, String password, String gender, String aboutUser, Timestamp dateTime, String profileImg) 
    {
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.aboutUser = aboutUser;
        this.dateTime = dateTime;
        this.profileImg = profileImg;
    }
    
    public User(int id, String name, String email, String password, String gender, String aboutUser, Timestamp dateTime) 
    {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.aboutUser = aboutUser;
        this.dateTime = dateTime;
    }

    public User(int id, String name, String email, String password, String gender, String aboutUser, Timestamp dateTime, String profileImg)
    {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.aboutUser = aboutUser;
        this.dateTime = dateTime;
        this.profileImg = profileImg;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAboutUser() {
        return aboutUser;
    }

    public void setAboutUser(String aboutUser) {
        this.aboutUser = aboutUser;
    }

    public Timestamp getDateTime() {
        return dateTime;
    }

    public void setDateTime(Timestamp dateTime) {
        this.dateTime = dateTime;
    }

    public String getProfileImg() {
        return profileImg;
    }

    public void setProfileImg(String profileImg) {
        this.profileImg = profileImg;
    }
    
}
