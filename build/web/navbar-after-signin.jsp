<%-- 
    Document   : navbar
    Created on : 29 May, 2022, 11:17:06 AM
    Author     : julia
--%>

<%@page import="com.techblog.entities.User"%>
<%@page import="org.omg.PortableInterceptor.USER_EXCEPTION"%>

<%

    User userDetails = (User)session.getAttribute("currentUser");
    
%>

<nav class="navbar navbar-expand-lg navbar-dark primary-background" style="width: 100%; top: 0px; left: 0px; position: fixed; z-index: 100;">
    <a class="navbar-brand" href="index.jsp"> <span class="fa fa-asterisk fa-spin"></span> Tech Blog</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="profile.jsp"> <span class="fa fa-bell"></span> All Posts <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="fa fa-check-square-o"></span> Categories
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">Programming Language</a>
                    <a class="dropdown-item" href="#">Projects Implementation</a>
                    <a class="dropdown-item" href="#">Database Implementation</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Data Structure</a>
                    <a class="dropdown-item" href="#">Computer Networking</a>
                    <a class="dropdown-item" href="#">Operating System</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"> <span class="fa fa-phone"></span> Contact</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#!" data-toggle="modal" data-target="#add-post-modal"> <span class="fa fa-pencil-square"></span> Do Post</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="user-all-posts.jsp"> <span class="fa fa-eye"></span> My All Posts</a>
            </li>
        </ul>
        <ul class="navbar-nav mr-right">
            <li class="nav-item active">
                <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"> <img src="profilepics/<%= userDetails.getProfileImg() %>" height="35" width="35" style="border-radius: 50%;" /> <%= userDetails.getName() %> </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="LogoutServlet"> <span class="fa fa-sign-out"></span> Logout</a>
            </li>
        </ul>
    </div>
</nav>
