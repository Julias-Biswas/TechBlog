<%-- 
    Document   : profile
    Created on : 30 May, 2022, 3:31:27 PM
    Author     : julia
--%>

<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.Message"%>
<%@page import="com.techblog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>

<%

    User user = (User) session.getAttribute("currentUser");

    int userId = user.getId();
    String userEmail = user.getEmail();

    if (user == null) {
        response.sendRedirect("signin.jsp");
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TechBlog - <%= user.getName()%> </title>

        <!--     Bootstrap 4 CSS      -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <!--     For Manual CSS     -->
        <link href="css/style.css" rel="stylesheet" type="text/css"/>

        <!--  Font Awesome Icons  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


        <style>
            .card:hover
            {
                margin: 0.5px;
                box-shadow: inset 0 -3em 3em rgba(0,0,0,0.1), 0 0  0 2px rgb(255,255,255), 0.3em 0.3em 1em rgba(0,0,0,0.3);
            }
            
            body
            {
                /*  Set Image in Background  */
                background: url(img/user-all-posts.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>

        <!--  Import Nav Bar Page Start  -->
        <%@include file="navbar-after-signin.jsp" %>
        <!--  Import Nav Bar Page End  -->

        <!--  Send Message Page Start  -->
        <%            Message msg = (Message) session.getAttribute("msg");

            if (msg != null) {
        %>
        <div class="alert <%= msg.getCssClass()%> alert-dismissible fade show text-center" role="alert">
            <strong>Message : </strong> <%= msg.getContent()%>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
                session.removeAttribute("msg");
            }

        %>
        <!--  Send Message Page End  -->

        <div class="container">
            <div class="row mt-5">
                <!--  Get All Categories  -->
                <%                    
                    PostDao postDao = new PostDao(ConnectionProvider.getConnection());

                    List<Post> list1 = postDao.getUserAllPostByUserId(userId, userEmail);

                    for (Post cc : list1) {
                %>
                <div class="col-md-4 d-flex mt-4">
                    <div class="card mt-3" style="width: 20rem;">
                        <img class="card-img-top" src="blog_pics/<%= cc.getpPic()%>" alt="Card image cap" width="100%" height="200" style="border: 1px solid #cccccc;"/>
                        <div class="card-body">
                            <h5 class="card-title text-center" style="color: #000000;"><%= cc.getpTitle()%></h5>
                            <!--<p class="card-text text-center"><%= cc.getpContent()%></p>--> 
                        </div>
                        <div class="card-footer primary-background">
                            
                            <% 
                                LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
                                
                            %>
                            
                            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i> <span class="like-counter"> <%= likeDao.countLikeOnPost(cc.getpId()) %></span></a>
                            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-comments"></i><span> 20</span></a>
                            <a href="show-blog-page.jsp?v=<%= cc.getpId()%>&list=<%= cc.getpTitle()%>&start_radio=<%= cc.getUserId() %>&link=<%= cc.getCatId() %>" class="btn btn-outline-light btn-sm mt-1">Read More...</a>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>

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


        <br><br><br><br><br>

        <!--     Bootstrap 4 JavaScript      -->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <!--  Sweet alert CDN  -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

        <!--     For Manual JavaScript     -->
        <script src="js/myjs.js" type="text/javascript"></script>

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
            //console.log("Loaded...");
            $("#add-post-form").on("submit", function (event){
            /*  This code gets called when form is submitted.  */
                event.preventDefault();
                //console.log("You have clicked on submit...");
                let form = new FormData(this);
                /*  Now requesting to Server  */
                $.ajax({
                    url: "AddPostServlet",
                    type: 'POST',
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        /*  Success...  */
                        //console.log("Success..." + data);
                        if (data.trim() === 'Done...')
                        {
                            swal("Good job!", "Your Blog Post Successfully!", "success")
                            .then((value) => {
                                window.location = "profile.jsp";
                               });
                        }
                        else
                        {
                            swal("Error!", "Something went wrong! Try again...", "error");
                            //console.log("Error in Else Part")
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        /*  Error...  */
                        //console.log("Error..." + jqXHR);
                        swal("Error!", "Something went wrong!, Try again...", "error");
                    },
                    processData: false,
                    contentType: false
                });
            });
        });
        </script>

    </body>
</html>
