/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techblog.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author julia
 */
public class ConnectionProvider 
{
    private static Connection con;
    
    public static Connection getConnection()
    {
        try
        {
            if( con == null )
            {
                /*  Driver Class Loaded with Full Package Name  */
                Class.forName("com.mysql.jdbc.Driver");

                /*  Connection Between Java Application into Database  */
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog","root","root");
            
            }
        }
        catch(ClassNotFoundException | SQLException e)
        {
            e.printStackTrace();
        }
        
        return con;
    }
}
