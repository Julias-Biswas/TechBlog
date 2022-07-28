<%-- 
    Document   : load-posts
    Created on : 2 Jun, 2022, 3:07:53 PM
    Author     : julia
--%>

<%@page import="com.techblog.entities.User"%>
<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.dao.PostDao"%>

<style>
    .card:hover
    {
        margin: 0.5px;
        box-shadow: inset 0 -3em 3em rgba(0,0,0,0.1), 0 0  0 2px rgb(255,255,255), 0.3em 0.3em 1em rgba(0,0,0,0.3);
    }
</style>

<%
    User user = (User) session.getAttribute("currentUser");
%>

<div class="row">
    <!--  this is load post page...  -->
    <%
        Thread.sleep(500);
        
        PostDao postdao = new PostDao(ConnectionProvider.getConnection());
        
        int cid = Integer.parseInt(request.getParameter("cid"));
                
        List<Post> posts = null;
        
        if( cid == 0 )
        {
            posts = postdao.getAllPost();
        }
        else
        {
            posts = postdao.getPostByCatId(cid);
        }
         
        if( posts.size() == 0 )
        {
            out.println("<h3 class='display-3 text-center'>No Posts in This Category...</h3>");
            return;
        }
            
        for (Post post : posts) {
    %>

    <div class="col-md-6 d-flex" >
        <div class="card mt-3" style="width: 18rem;">
            <img class="card-img-top" src="blog_pics/<%= post.getpPic() %>" alt="Card image cap" width="100%" height="150" style="border: 1px solid #cccccc;"/>
            <div class="card-body">
                <h5 class="card-title text-center" style="color: #000000;"><%= post.getpTitle() %></h5>
                <!--<p class="card-text text-center"><%= post.getpContent() %></p>--> 
            </div>
            <div class="card-footer primary-background">
                
                <% 
                    LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
                                
                %>
                
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i> <span class="like-counter"> <%= likeDao.countLikeOnPost(post.getpId()) %></span></a>
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-comments"></i><span> 20</span></a>
                <a href="show-blog-page.jsp?v=<%= post.getpId() %>&list=<%= post.getpTitle() %>&start_radio=<%= post.getUserId() %>&link=<%= post.getCatId() %>" class="btn btn-outline-light btn-sm mt-1">Read More...</a>
            </div>
        </div>
    </div>

    <%
        }

    %>
</div>

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