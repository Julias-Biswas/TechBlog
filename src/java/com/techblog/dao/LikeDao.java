/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techblog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author julia
 */
public class LikeDao 
{
    Connection con;

    public LikeDao(Connection con) 
    {
        this.con = con;
    }
    
    /*  Like insert into a database  */
    public boolean insertLike(int pId, String uEmail, int uId)
    {
        boolean status = false;
        
        try
        {
            String query = "INSERT INTO likes(pid, uid, uEmail) VALUES(?,?,?)";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setInt(1, pId);
            ps.setInt(2, uId);
            ps.setString(3, uEmail);
            
            ps.executeUpdate();
            
            status = true;
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return status;
    }
    
    /*  Count no of like in a perticular post  */
    public int countLikeOnPost(int pId)
    {
        int count = 0;
        
        try
        {
            String query = "SELECT COUNT(*) FROM likes WHERE pid=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setInt(1, pId);
            
            ResultSet rs = ps.executeQuery();
            
            if( rs.next() )
            {
                count = rs.getInt("COUNT(*)");
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return count;
    }
    
    /*  Is user liked or not  */
    public boolean isLikedByUser(int pId, int uId, String uEmail)
    {
        boolean status = false;
        
        try
        {
            String query = "SELECT * FROM likes WHERE pid=? AND uid=? AND uEmail=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setInt(1, pId);
            ps.setInt(2, uId);
            ps.setString(3, uEmail);
            
            ResultSet rs = ps.executeQuery();
            
            if( rs.next() )
            {
                status = true;
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return status;
    }
    
    /*  Delete user like from database  */
    public boolean deleteLike(int pId, int uId, String uEmail)
    {
        boolean status = false;
        
        try
        {
            String query = "DELETE FROM likes WHERE pid=? AND uid=? AND uEmail=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setInt(1, pId);
            ps.setInt(2, uId);
            ps.setString(3, uEmail);
            
            ps.executeUpdate();
            
            status = true;
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return status;
    }
}
