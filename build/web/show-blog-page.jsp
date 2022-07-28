<%-- 
    Document   : show-blog-page
    Created on : 2 Jun, 2022, 11:37:58 PM
    Author     : julia
--%>

<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="com.techblog.dao.UserDao"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>

<%

    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("signin.jsp");
    }

%>

<%  
    int postId = Integer.parseInt(request.getParameter("v"));
    String postTitle = request.getParameter("list");
    int postUserId = Integer.parseInt(request.getParameter("start_radio"));
    int postCatId = Integer.parseInt(request.getParameter("link"));

    /*  Get perticular post from database  */
    PostDao postDao = new PostDao(ConnectionProvider.getConnection());

    Post post = postDao.getPostByPostId(postId, postTitle, postCatId, postUserId);
    
    /*  Get perticular user data and category from database  */
    UserDao userDao = new UserDao(ConnectionProvider.getConnection());
    
    User userdetails = userDao.getUserByUserId(postUserId);
    
    Category categorydetails = userDao.getCategoryByCategoryId(postCatId);

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TechBlog - <%= post.getpTitle()%></title>

        <!--     Bootstrap 4 CSS      -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <!--     For Manual CSS     -->
        <link href="css/style.css" rel="stylesheet" type="text/css"/>

        <!--  Font Awesome Icons  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <style>
            .post-content
            {
                font-size: 18px;
            }
                        
            .row-user
            {
                border: 1px solid #b8fdb8;
                padding-top: 5px;
            }
            
            /*  Set Image in Background  */
            body
            {
                background: url(img/background-image.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
        
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/bn_IN/sdk.js#xfbml=1&version=v14.0" nonce="MJ5CCyxV"></script>

<!--        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v14.0" nonce="9uqKZuB1"></script>-->
        
    </head>
    <body>

        <!--  Import Nav Bar Page Start  -->
        <%@include file="navbar-after-signin.jsp" %>
        <!--  Import Nav Bar Page End  -->
        
        <!--  Main Content of the body Start  -->
        <div class="container mt-5">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <div class="card mt-5" style="width: 100%;">
                        <div class="card-header primary-background text-white text-center">
                            <h2><%= post.getpTitle() %></h2>
                        </div>
                        <img class="card-img-top" src="blog_pics/<%= post.getpPic() %>" alt="Card image cap" width="100%" height="400" style="border: 1px solid #cccccc;" />
                        <div class="container">
                            <div class="row my-1 row-user">
                                <div class="col-md-8">
                                    <p class="font-weight-bold"> <a href="#!" style="text-decoration: none;" title="Show This User Profile..."><%= userdetails.getName() %></a> has posted : </p>
                                </div>
                                <div class="col-md-4">
                                    <p class="font-italic font-weight-bold"> <%= post.getpDate().toLocaleString() %></p>
                                </div>
                            </div>
                        </div>
                        <div class="card-body text-center">
                            <h4 class="card-title" style="color: #000000;"><%= post.getpTitle() %></h4>
                            <p class="card-text post-content"><%= post.getpContent() %></p>
                        </div>
                        <ul class="list-group list-group-flush post-code">
                            <li class="list-group-item"><pre><%= post.getpCode() %></pre></li>
                        </ul>
                        <div class="card-body text-center">
                            <h3 style="color: #0000cc;">Details of the person who posted it</h3>
                            <div class="container text-center">
                                <div class="row">
                                    <div class="col-md-4">
                                        
                                    </div>
                                    <div class="col-md-4">
                                        <img class="card-img-top" src="profilepics/<%= userdetails.getProfileImg() %>" alt="Card image cap" width="50" height="200" style="border-radius: 50%;" /> 
                                    </div>
                                    <div class="col-md-4">
                                         
                                    </div>
                                </div>
                            </div>
                            <strong>User Name : <i class="fa fa-user-circle"></i>  <%= userdetails.getName() %></strong> <br>
                            <strong>User Email ID : <i class="fa fa-envelope"></i>  <%= post.getUserEmail() %></strong> <br>
                            <strong>User Gender : <i class="fa fa-venus-mars"></i>  <%= userdetails.getGender() %></strong> <br>
                            <strong>User Register : <i class="fa fa-calendar"></i>  <%= userdetails.getDateTime().toLocaleString() %></strong> <br>
                            <strong>Post Category Name : <i class="fa fa-check-square"></i>  <%= categorydetails.getName() %></strong> <br>
                            <strong>Post Date : <i class="fa fa-calendar-check-o"></i>  <%= post.getpDate().toLocaleString() %></strong>
                        </div>
                        <div class="card-footer primary-background text-center">
                            
                            <% 
                                LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
                                
                            %>
                            
                            <a href="#!" onclick="pleaseDoLikes(<%= post.getpId() %>,<%= user.getId() %> )" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i> <span class="like-counter"> <%= likeDao.countLikeOnPost(post.getpId()) %></span></a>
                            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-comments"></i><span> 20</span></a>
                            
                        </div>
                        <div class="card-footer">
                            <!--<div class="fb-comments" data-href="http://localhost:8084/TechBlog/show-blog-page.jsp?v=<%= post.getpId() %>&amp;list=<%= post.getpTitle() %>&amp;start_radio=<%= userdetails.getId() %>&amp;link=<%= categorydetails.getcId() %>" data-width="" data-numposts="5"></div>-->
                            <div class="fb-comments" data-href="https://developers.facebook.com/docs" data-width="" data-numposts="5"></div>
                            <!--<div class="fb-comments" data-href="http://localhost:8084/TechBlog/show-blog-page.jsp?v=<%= post.getpId() %>&list=<%= post.getpTitle() %>&start_radio=<%= userdetails.getId() %>&link=<%= categorydetails.getcId() %>" data-width="" data-numposts="5"></div>-->
                        </div>
                      </div>
                </div>
            </div>
        </div>
        <!--  Main Content of the body End  -->
        

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
        
        <!--  View Source Page Disable Start  --> 
        <SCRIPT language=JavaScript>

            <!-- http://www.spacegun.co.uk -->

            var message = "                                          We are Sorry!"
                    +"\n"+"                              View Page Source are Disable";

            function rtclickcheck(keyp) {
                if (navigator.appName === "Netscape" && keyp.which === 3) {
                    alert(message);
                    return false;
                }

                if (navigator.appVersion.indexOf("MSIE") !== -1 && event.button === 2) {
                    alert(message);
                    return false;
                }
            }

            document.onmousedown = rtclickcheck;

        </SCRIPT>
        <!--  View Source Page Disable End  --> 
        
    </body>
</html>
