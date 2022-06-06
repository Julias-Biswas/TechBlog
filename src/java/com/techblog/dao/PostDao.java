/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techblog.dao;

import com.techblog.entities.Category;
import com.techblog.entities.Post;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author julia
 */
public class PostDao 
{
    Connection con;

    public PostDao(Connection con) 
    {
        this.con = con;
    }
    
    public ArrayList<Category> getAllCategories()
    {
        ArrayList<Category> list = new ArrayList<>();
        
        try
        {
            String query = "SELECT * FROM categories";
            
            Statement st = this.con.createStatement();
            
            ResultSet rs = st.executeQuery(query);
            
            while( rs.next() )
            {
                int cId = rs.getInt("cid");
                String cName = rs.getString("name");
                String cDescription = rs.getString("description");
                
                Category category = new Category(cId, cName, cDescription);
                
                list.add(category);
                
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public boolean savePost(Post post)
    {
        boolean flag = false;
        
        try
        {
            String query = "INSERT INTO posts(pTitle, pContent, pCode, pPic, catId, userEmail, userId) VALUES(?,?,?,?,?,?,?)";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setString(1, post.getpTitle());
            ps.setString(2, post.getpContent());
            ps.setString(3, post.getpCode());
            ps.setString(4, post.getpPic());
            ps.setInt(5, post.getCatId());
            ps.setString(6, post.getUserEmail());
            ps.setInt(7, post.getUserId());
            
            ps.executeUpdate();
            
            flag = true;
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return flag;
    }
    
    /*  Get all the post from database  */
    public List<Post> getAllPost()
    {
        List<Post> list = new ArrayList<>();
        
        /*  Fetch all the post in front end  */
        try
        {
            String query = "SELECT * FROM posts ORDER BY pid DESC";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ResultSet rs = ps.executeQuery();
            
            while( rs.next() )
            {
                /*  Get all posts from database  */
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int catId = rs.getInt("catId");
                String userEmail = rs.getString("userEmail");
                int userId = rs.getInt("userId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userEmail, userId);
                
                list.add(post);
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public List<Post> getPostByCatId(int catId)
    {
        List<Post> list = new ArrayList<>();
        
        /*  Fetch all the post by id  */
        /*  Fetch all the post in front end  */
        try
        {
            String query = "SELECT * FROM posts WHERE catId=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setInt(1, catId);
            
            ResultSet rs = ps.executeQuery();
            
            while( rs.next() )
            {
                /*  Get all posts from database  */
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                String userEmail = rs.getString("userEmail");
                int userId = rs.getInt("userId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userEmail, userId);
                
                list.add(post);
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
    }
    
    /*  Get a perticular post by using postId, postTitle, postCatId and userId  */
    public Post getPostByPostId(int postId, String postTitle, int postCatId, int userId)
    {
        Post post = null;
        
        try
        {
            String query = "SELECT * FROM posts WHERE pid=? AND pTitle=? AND catId=? AND userId=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setInt(1, postId);
            ps.setString(2, postTitle);
            ps.setInt(3, postCatId);
            ps.setInt(4, userId);
            
            ResultSet rs = ps.executeQuery();
            
            if( rs.next() )
            {
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                String userEmail = rs.getString("userEmail");
                
                post = new Post(postId, postTitle, pContent, pCode, pPic, pDate, postCatId, userEmail, userId);
                
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return post;
    }
    
    /*  Get perticular user all the post from database  */
    public List<Post> getUserAllPostByUserId(int userId, String userEmail)
    {
        List<Post> list = new ArrayList<>();
        
        try
        {
            String query = "SELECT * FROM posts WHERE userId=? AND userEmail=? ORDER BY pid DESC";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setInt(1, userId);
            ps.setString(2, userEmail);
            
            ResultSet rs = ps.executeQuery();
            
            while( rs.next() )
            {
                /*  Get all posts from database  */
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPic = rs.getString("pPic");
                Timestamp pDate = rs.getTimestamp("pDate");
                int catId = rs.getInt("catId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, catId, userEmail, userId);
                
                list.add(post);
                
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
    }
}
