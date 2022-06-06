/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techblog.dao;

import com.techblog.entities.Category;
import com.techblog.entities.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

/**
 *
 * @author julia
 */
public class UserDao 
{
    private Connection con;

    public UserDao(Connection con) 
    {
        this.con = con;
    }
    
    
    /*  Creating Method to insert user to database  */
    public boolean saveUser(User user)
    {
        boolean status = false;
        
        try
        {
            /*  User ---> Database  */
            String query = "INSERT INTO user(name,email,password,gender,about_user) VALUES(?,?,?,?,?)";
            
            PreparedStatement ps = this.con.prepareStatement(query);
            
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getGender());
            ps.setString(5, user.getAboutUser());
            
            
            ps.executeUpdate();
            
            status = true;
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return status;
    }
    
    
    /*  Get user by user email and user password  */
    public User getUserByEmailAndPassword(String email, String password)
    {
        User user = null;
        
        try
        {
            String query = "SELECT * FROM user WHERE email=? AND password=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setString(1, email);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if( rs.next() )
            {
                user = new User();
                
                /*  Get data from database  */
                String name = rs.getString("name");
                String gender = rs.getString("gender");
                String about_user = rs.getString("about_user");
                Timestamp rdate = rs.getTimestamp("rdate");
                
                /*  Set data to user object  */
                user.setId(rs.getInt("id"));
                user.setName(name);
                user.setEmail(email);
                user.setPassword(password);
                user.setGender(gender);
                user.setAboutUser(about_user);
                user.setDateTime(rdate);
                user.setProfileImg(rs.getString("profile_img"));
                
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return user;
    }
    
    public boolean updateUser(User user)
    {
        boolean status = false;
        
        try
        {
            String query = "UPDATE user SET name=? , password=? , about_user=? , profile_img=? WHERE id=? AND email=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setString(1, user.getName());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getAboutUser());
            ps.setString(4, user.getProfileImg());
            ps.setInt(5, user.getId());
            ps.setString(6, user.getEmail());
            
            ps.executeUpdate();
            
            status = true;
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return status;
    }
    
    /*  Get user details by using postId  */
    public User getUserByUserId(int postUserId)
    {
        User user = null;
        
        try
        {
            String query = "SELECT * FROM user WHERE id=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setInt(1, postUserId);
            
            ResultSet rs = ps.executeQuery();
            
            if( rs.next() )
            {
                String name = rs.getString("name");
                String email = rs.getString("email");
                String gender = rs.getString("gender");
                Timestamp rdate = rs.getTimestamp("rdate");
                String profile_img = rs.getString("profile_img");
                
                user = new User(name, email, gender, rdate, profile_img);
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return user;
    }
    
    /*  Get category details by using catId  */
    public Category getCategoryByCategoryId(int catId)
    {
        Category category = null;
        
        try
        {
            String query = "SELECT * FROM categories WHERE cid=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setInt(1, catId);
            
            ResultSet rs = ps.executeQuery();
            
            if( rs.next() )
            {
                
                String catName = rs.getString("name");
                String catDescription = rs.getString("description");
                
                category = new Category(catName, catDescription);
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return category;
    }
}
