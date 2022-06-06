<%-- 
    Document   : navbar
    Created on : 29 May, 2022, 11:17:06 AM
    Author     : julia
--%>

<nav class="navbar navbar-expand-lg navbar-dark primary-background" style="width: 100%; top: 0px; left: 0px; position: fixed; z-index: 100;">
    <a class="navbar-brand" href="index.jsp"> <span class="fa fa-asterisk fa-spin"></span> Tech Blog</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="#"> <span class="fa fa-bell"></span> Code with Julias <span class="sr-only">(current)</span></a>
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
                <a class="nav-link" href="signin.jsp"> <span class="fa fa-sign-in"></span> Sign In</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="signup.jsp"> <span class="fa fa-user"></span> Sign Up</a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-light my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>
</nav>
