<%-- 
    Document   : index.jsp
    Created on : 29 May, 2022, 10:04:24 AM
    Author     : julia
--%>

<%@page import="com.techblog.entities.Message"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign In Page</title>

        <!--     Bootstrap 4 CSS      -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <!--     For Manual CSS     -->
        <link href="css/style.css" rel="stylesheet" type="text/css"/>

        <!--  Font Awesome Icons  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!--  For Clip Path Banner Background  -->
        <style>
            .banner-background
            {
                clip-path: polygon(50% 0%, 100% 0, 100% 100%, 83% 95%, 68% 100%, 53% 95%, 34% 100%, 18% 95%, 0 100%, 0 0);
            }
        </style>

    </head>
    <body>

        <!--  Import Nav Bar Page  -->
        <%@include file="navbar.jsp" %>

        <main class="d-flex align-items-center primary-background banner-background" style="height: 90vh">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <div class="card mt-5">
                            <div class="card-header text-center">
                                <span class="fa fa-user-circle fa-3x"></span>
                                <h1>Sign In Here</h1>
                            </div>
                            <% 
                            
                                Message msg = (Message)session.getAttribute("msg");
                                
                                if( msg != null )
                                {
                            %>
                                    <div class="alert <%= msg.getCssClass() %> alert-dismissible fade show text-center" role="alert">
                                        <strong>Message : </strong> <%= msg.getContent() %>
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                            <%
                                    session.removeAttribute("msg");
                                }
                                
                            %>
                            <div class="card-body">
                                <form action="LoginServlet" method="POST">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Email address</label>
                                        <input type="email" name="userEmail1" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="name@example.com" required="">
                                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputPassword1">Password</label>
                                        <input type="password" name="userPassword1" class="form-control" id="exampleInputPassword1" placeholder="Password" required="">
                                    </div>
                                    <div class="form-check text-center">
                                        <input type="checkbox" name="checkbox1" class="form-check-input" id="exampleCheck1">
                                        <label class="form-check-label" for="exampleCheck1">Check me out</label>
                                    </div>
                                    <div class="container text-center mt-3">
                                        <button type="submit" class="btn btn-primary">Sign In</button>
                                    </div>
                                </form>
                                <p class="text-center mt-1"><a href="forgot-password.jsp">Forgot Password?</a></p>

                                <p class="text-center">New User ? <a href="signup.jsp">Sign Up</a></p>
                            </div>
                            <div class="card-footer">

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>


        <br><br><br><br><br>

        <!--     Bootstrap 4 JavaScript      -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <!--     For Manual JavaScript     -->
        <script src="js/myjs.js" type="text/javascript"></script>

    </body>
</html>
