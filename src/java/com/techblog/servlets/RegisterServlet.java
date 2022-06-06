/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techblog.servlets;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author julia
 */

/*  MultipartConfig annotation is basically accept all data like text, image etc.  */
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
                        
            
            /*  Fetch Term & Condition data  */
            String user_check2 = request.getParameter("user_check1");
            
            
            if( user_check2 == null || user_check2.equals("") )
            {
                /*  User can't click CHECK BOX  */
                out.println("Box not Checked...!!!");
            }
            else
            {
                /*  Fetch All User data  */
                String user_name2 = request.getParameter("user_name1");
                String user_email2 = request.getParameter("user_email1");
                String user_password2 = request.getParameter("user_password1");
                String user_gender2 = request.getParameter("user_gender1");
                String user_about2 = request.getParameter("user_about1");
                
                
                /*  Create User Object and set all data to that Object  */
                User user = new User(user_name2, user_email2, user_password2, user_gender2, user_about2);
                
                
                /*  Create a UserDao Object  */
                UserDao userdao = new UserDao(ConnectionProvider.getConnection());
                
                if( userdao.saveUser(user) )
                {
                    /*  Return True means save data into database  */
                    out.println("Done...");
                }
                else
                {
                    out.println("Error...");
                }
                
            }
            
            
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
