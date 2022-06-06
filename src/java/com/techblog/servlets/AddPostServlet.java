/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.techblog.servlets;

import com.techblog.dao.PostDao;
import com.techblog.entities.Post;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author julia
 */
@MultipartConfig
public class AddPostServlet extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            
            
            /*  Get all Post information from user side  */
            String userEmail = request.getParameter("userEmail1");
            int cId = Integer.parseInt(request.getParameter("cId1"));
            String pTitle = request.getParameter("pTitle1");
            String pContent = request.getParameter("pContent1");
            String pCode = request.getParameter("pCode1");
            Part part = request.getPart("pPic1");
            
            
            /*  getting current user id  */
            HttpSession session = request.getSession();
            
            User user = (User)session.getAttribute("currentUser");
            
            
            //out.println("Your Post Email is : "+userEmail);
            //out.println("\nPicture : "+part.getSubmittedFileName());
            
            Post post = new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), null, cId, userEmail, user.getId());
            
            PostDao postdao = new PostDao(ConnectionProvider.getConnection());
            
            if( postdao.savePost(post) )
            {
                String blogPostFilePath = request.getRealPath("/")+"/blog_pics"+File.separator + part.getSubmittedFileName();
                
                Helper.saveFile(part.getInputStream(), blogPostFilePath);
                
                out.println("Done...");
            }
            else
            {
                out.println("Error...");
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
