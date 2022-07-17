<%-- 
    Document   : index.jsp
    Created on : 29 May, 2022, 10:04:24 AM
    Author     : julia
--%>

<%@page import="com.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    User user = (User) session.getAttribute("currentUser");

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>

        <!--     Bootstrap 4 CSS      -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <!--     For Manual CSS     -->
        <link href="css/style.css" rel="stylesheet" />

        <!--  Font Awesome Icons  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!--  For Clip Path Banner Background  -->
        <style>
            body
            {
                background: url(img/profile-background-image.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
            
            .banner-background
            {
                clip-path: polygon(50% 0%, 100% 0, 100% 90%, 64% 100%, 31% 91%, 0 100%, 0 0);
            }
            
            /*  CSS media for responsive  */
            @media screen and (min-width: 1020px)
            {
                .list-group
                {
                    
                }
            }
        </style>

    </head>
    <body>

        <!--  Import Nav Bar Page  -->
        <%--<%@include file="navbar.jsp" %>--%>
        <!--  Import Nav Bar Page Start  -->
        <% 
        
            if (user == null ? user == null : user.equals("null"))
            {
        %>
                <%@include file="navbar.jsp" %>
        <%
            }
            else
            {
        %>
                <%@include file="navbar-after-signin.jsp" %>
        <%
            }
        %>
        
        <!--  Import Nav Bar Page End  -->

        <!--  For Create Banner  -->
        <div class="container-fluid p-0 m-0">
            <div class="jumbotron primary-background text-white banner-background" style="height: auto;">
                <div class="container">
                    <h3 class="display-3">Welcome to Tech Blog</h3>
                    <p class="text-center">
                        A programming language is any set of rules that converts strings,
                        or graphical program elements in the case of visual programming 
                        languages, to various kinds of machine code output. Programming 
                        languages are one kind of computer language, and are used in 
                        computer programming to implement algorithms. Programming language 
                        theory is a subfield of computer science that deals with the design,
                        implementation, analysis, characterization, and classification of
                        programming languages.
                    </p>
                    <p class="text-center">
                        Most programming languages consist of instructions for computers. 
                        There are programmable machines that use a set of specific instructions,
                        rather than general programming languages. Since the early 1800s, programs
                        have been used to direct the behavior of machines such as Jacquard looms,
                        music boxes and player pianos. The programs for these machines did not 
                        produce different behavior in response to different inputs or conditions.
                    </p>
                    <% 
                        if( user == null )
                        {
                            
                    %>
                    <a href="signup.jsp" class="btn btn-outline-light btn-lg"> <span class="fa fa-user"></span> Start ! It's Free</a>
                    <a href="signin.jsp" class="btn btn-outline-light btn-lg"> <span class="fa fa-sign-in"></span> Sign In</a>
                    <% 
                        }
                    %>
                </div>
            </div>
        </div>
        
        <%
            if( user != null || user == null )
            {
        %>        
        
                <!--  Main Body of this projects Start  -->
                <main>
                    <div class="container mt-5">
                        <div class="row">
                            <!--  First column  -->
                            <div class="col-md-4 mt-5">
                                <!--  View All Categories  -->
                                <div class="list-group">
                                    <a href="#list-home" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" role="tab" aria-controls="home">All Posts</a>
                                    <!--  Get All Categories  -->
                                    <% 
                                        PostDao postDao= new PostDao(ConnectionProvider.getConnection());

                                        ArrayList<Category> list1 = postDao.getAllCategories();

                                        for( Category cc : list1 )
                                        {
                                    %>

                                            <a href="#!" onclick="getPosts(<%= cc.getcId() %>, this)" class="c-link list-group-item list-group-item-action" ><%= cc.getName() %></a>

                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <!--  Second column  -->
                            <div class="col-md-8 mt-5">
                                <!--  View refresh icon  -->
                                <div class="container text-center" id="loader">
                                    <i class="fa fa-refresh fa-3x fa-spin"></i>
                                    <h3 class="mt-2">Loading...</h3>
                                </div>
                                <!--  View all post depends on categories  -->
                                <div class="container-fluid" id="post-container">

                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <!--  Main Body of this projects End  -->
        
        <%
            }   
        %>
        
        
        
        <% 
        
            if( user != null )
            {   
        %>
        <!--  Profile Modal Start  -->

        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="profilepics/<%= user.getProfileImg()%>" height="200" width="200" style="border-radius: 50%;"/>
                            <h4 class="modal-title mt-3" id="exampleModalLabel"> <%= user.getName()%> </h4>

                            <!--  User Profile Details  -->
                            <div id="profile-details">
                                <table class="table table-hover mt-4">
                                    <tbody>
                                        <tr>
                                            <th scope="row">ID : </th>
                                            <td><%= user.getId()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Email : </th>
                                            <td><%= user.getEmail()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Gender : </th>
                                            <td colspan="2"><%= user.getGender()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Status : </th>
                                            <td colspan="2"><%= user.getAboutUser()%></td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Register on : </th>
                                            <td colspan="2"><%= user.getDateTime()%></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <!--  User Profile Edit  -->
                            <div id="profile-edit" style="display: none;">
                                <h3 class="mt-2">Please Edit Carefully</h3>
                                <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                    <table class="table mt-4">
                                        <tbody>
                                            <tr>
                                                <th scope="row">ID : </th>
                                                <td><input type="number" class="form-control" name="userId1" value="<%= user.getId()%>" readonly=""/></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">Name : </th>
                                                <td><input type="text" class="form-control" name="userName1" value="<%= user.getName()%>" /></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">Email : </th>
                                                <td><input type="email" class="form-control" name="userEmail1" value="<%= user.getEmail()%>" readonly=""/></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">Password : </th>
                                                <td><input type="password" class="form-control" name="userPassword1" value="<%= user.getPassword()%>" /></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">Gender : </th>
                                                <td colspan="2"><input type="text" class="form-control" name="userGender1" value="<%= user.getGender()%>" readonly=""/></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">Status : </th>
                                                <td colspan="2"><textarea class="form-control" name="userAbout1" rows="3"><%= user.getAboutUser()%></textarea></td>
                                            </tr>
                                            <tr>
                                                <th scope="row">New Pic : </th>
                                                <td><input type="file" name="userImage1" class="form-control" required=""/></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary">Save / Update</button>
                                    </div>

                                </form>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-button" type="button" class="btn btn-primary">Modify</button>
                    </div>
                </div>
            </div>
        </div>
        <!--  Profile Modal End  -->

        <!--  Add Post Modal Start  -->
        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header primary-background">
                        <h5 class="modal-title text-white" id="exampleModalLongTitle">Create Your New Post</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="AddPostServlet" method="POST" id="add-post-form">
                            <div class="form-group">
                                <input type="email" class="form-control" name="userEmail1" value="<%= user.getEmail()%>" readonly="" style="display: none;"/>
                            </div>
                            <div class="form-group">
                                <select class="form-control" name="cId1">
                                    <option selected="" disabled="">--- Select Post Category ---</option>
                                    <%

                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());

                                        ArrayList<Category> list = postd.getAllCategories();

                                        for (Category c : list) {
                                    %>
                                    <option value="<%= c.getcId()%>"><%= c.getcId() + ". " + c.getName()%></option>
                                    <%
                                        }

                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" name="pTitle1" id="exampleInputEmail1" placeholder="Enter Post Title" required="" />
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" name="pContent1" rows="4" placeholder="Enter Post Content" required=""></textarea>
                            </div>
                            <div class="form-group">
                                <textarea class="form-control" name="pCode1" rows="4" placeholder="Enter Post Code / Program (if any)"></textarea>
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPostImage1">Select Post Image</label>
                                <input type="file" name="pPic1" class="form-control" required=""/>
                            </div>
                            <div class="container mt-4 text-center">
                                <button type="submit" class="btn btn-outline-primary">Create Your New Post</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!--  Add Post Modal End  -->
        
        <%
            }
        %>

        
        

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

                let editStatus = false;
                //console.log("Testing..");
                $('#edit-profile-button').click(function () {
                    //console.log("Button Click..");
                    if (editStatus == false)
                    {
                        //console.log("Status False..");
                        $('#profile-details').hide();
                        $('#profile-edit').show();
                        editStatus = true;
                        $(this).text("Back");
                    }
                    else
                    {
                        //console.log("Status True..");
                        $('#profile-details').show();
                        $('#profile-edit').hide();
                        editStatus = false;
                        $(this).text("Modify");
                    }

                });
            });       
        </script>

        <!--  Now Add Post JS  -->
        <script>
            $(document).ready(function (e){
            console.log("Loaded...");
            $("#add-post-form").on("submit", function (event){
            /*  This code gets called when form is submitted.  */
            event.preventDefault();
                console.log("You have clicked on submit...");
                let form = new FormData(this);
                /*  Now requesting to Server  */
                $.ajax({
                    url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                        /*  Success...  */
                            console.log("Success..." + data);
                            if (data.trim() === 'Done...')
                            {
                                console.log(data.trim());
                                swal("Good job!", "Your Blog Post Successfully!", "success")
                                .then((value) => {
                                    window.location = "profile.jsp";
                                });
                            }
                            else
                            {
                                swal("Error!", "Something went wrong! Try again...", "error");
                                console.log("Error in Else Part")
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            /*  Error...  */
                            console.log("Error..." + jqXHR);
                            swal("Error!", "Something went wrong!, Try again...", "error");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>
        
        <!--  Loading Post using AJAX  -->
        <script>
            
            function getPosts(catId,temp)
            {
                $("#loader").show();
                $('#post-container').hide();
                
                $(".c-link").removeClass('active');
                
                $.ajax({
                    url: "load-posts.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        //console.log(data);
                        $("#loader").hide();
                        $('#post-container').show();
                        $('#post-container').html(data);
                        $(temp).addClass('active');
                    }
                });
            }
            
            $(document).ready(function (e){
                //console.log("Loading Post...");
                
                let allPostRef = $('.c-link')[0];
                
                getPosts(0, allPostRef);
                
            });
        </script>
        
    </body>
</html>
