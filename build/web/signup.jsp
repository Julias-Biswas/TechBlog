<%-- 
    Document   : index.jsp
    Created on : 29 May, 2022, 10:04:24 AM
    Author     : julia
--%>

<%@page import="java.sql.Connection"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up Page</title>

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
                clip-path: polygon(50% 0%, 100% 0, 94% 46%, 100% 100%, 78% 97%, 54% 93%, 26% 96%, 0 100%, 6% 47%, 0 0);
            }
        </style>

    </head>
    <body>

        <!--  Import Nav Bar Page  -->
        <%@include file="navbar.jsp" %>

        <main class="d-flex align-items-center primary-background banner-background" style="height: 140vh">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 offset-md-3">
                        <div class="card">
                            <div class="card-header text-center">
                                <span class="fa fa-user-plus fa-3x"></span>
                                <h1>Sign Up Here</h1>
                            </div>
                            <div class="card-body">
                                <form id="reg-form" action="RegisterServlet" method="POST">
                                    <div class="form-group">
                                        <label for="exampleInputName1">User Name</label>
                                        <input type="text" name="user_name1" class="form-control" id="exampleInputName1" aria-describedby="nameHelp" placeholder="Enter Name" required="">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Email address</label>
                                        <input type="email" name="user_email1" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="name@example.com" required="">
                                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputPassword1">Password</label>
                                        <input type="password" name="user_password1" class="form-control" id="exampleInputPassword1" placeholder="Password" required="">
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputGender1">Select Gender</label> 
                                        <div style="float: right;">
                                            <input type="radio" id="exampleInputMale1" name="user_gender1" value="Male">Male
                                            <input type="radio" id="exampleInputFemale1" name="user_gender1" value="Female">Female
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputAbout1">User About</label>
                                        <textarea type="text" name="user_about1" class="form-control" id="exampleInputAbout1" placeholder="Enter Something About Yourself"></textarea>
                                    </div>
                                    <div class="form-check text-center">
                                        <input type="checkbox" name="user_check1" class="form-check-input" id="exampleCheck1">
                                        <label class="form-check-label" for="exampleCheck1">Agree <a href="#">terms & conditions</a></label>
                                    </div>
                                    <br>
                                    <div class="container text-center" id="loader" style="display: none;">
                                        <span class="fa fa-refresh fa-spin fa-2x"></span>
                                        <h5>Please wait...</h5>
                                    </div>
                                    <br>
                                    <center> <button id="submit-btn" type="submit" class="btn btn-primary">Sign Up</button> </center>
                                </form>
                                <br>
                                <p class="text-center">Already have an account ? <a href="signin.jsp">Sign In</a></p>
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

        <!--  For Sweet alert  -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>


        <script>
            $(document).ready(function () {
                console.log("Loaded...");

                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);
                    
                    $("#submit-btn").hide();
                    $("#loader").show();

                    /*   Send RegisterServlet Page  */
                    $.ajax({
                        url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            console.log(data)

                            $("#submit-btn").show();
                            $("#loader").hide();

                            if( data.trim()==='Done...' )
                            {
                                swal("Good Job!","Sign Up Successfully! We redirecting to Sign In page.","success")
                                    .then((value) => {
                                        window.location = "signin.jsp"
                                });
                            }
                            else
                            {
                                swal(data);
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(jqXHR);

                            $("#submit-btn").show();
                            $("#loader").hide();

                            swal("Sign Up Failed! Something went wrong..try again");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>

    </body>
</html>
