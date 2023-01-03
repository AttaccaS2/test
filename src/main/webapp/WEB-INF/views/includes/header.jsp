<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>   
<%-- <sec:authorize access="isAnonymous()">
<script>
location.href="/customLogin";
</script>
</sec:authorize>
					 --%>	 
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
	<meta name="description" content="Admin, Dashboard, Bootstrap" />
	<link rel="shortcut icon" sizes="196x196" href="/resources/assets/images/logo.png">
	<title>비공식 작은 도서관 협의회</title>
	
	<link rel="stylesheet" href="/resources/libs/bower/font-awesome/css/font-awesome.min.css">
	<link rel="stylesheet" href="/resources/libs/bower/material-design-iconic-font/dist/css/material-design-iconic-font.css">
	<!-- build:css /admin/resources/assets/css/app.min.css -->
	<link rel="stylesheet" href="/resources/libs/bower/animate.css/animate.min.css">
	<link rel="stylesheet" href="/resources/libs/bower/fullcalendar/dist/fullcalendar.min.css">
	<link rel="stylesheet" href="/resources/libs/bower/perfect-scrollbar/css/perfect-scrollbar.css">
	<link rel="stylesheet" href="/resources/assets/css/bootstrap.css">
	<link rel="stylesheet" href="/resources/assets/css/core.css">
	<link rel="stylesheet" href="/resources/assets/css/app.css">
	<!-- endbuild -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway:400,500,600,700,800,900,300">
	<script src="/resources/libs/bower/breakpoints.js/dist/breakpoints.min.js"></script>
	<!-- build:js /admin/resources/assets/js/core.min.js -->
	<script src="/resources/libs/bower/jquery/dist/jquery.js"></script>
	<script src="/resources/libs/bower/jquery-ui/jquery-ui.min.js"></script>
	<script src="/resources/libs/bower/jQuery-Storage-API/jquery.storageapi.min.js"></script>
	<script src="/resources/libs/bower/bootstrap-sass/assets/javascripts/bootstrap.js"></script>
	<script src="/resources/libs/bower/jquery-slimscroll/jquery.slimscroll.js"></script>
	<script src="/resources/libs/bower/perfect-scrollbar/js/perfect-scrollbar.jquery.js"></script>
	<script src="/resources/libs/bower/PACE/pace.min.js"></script>
	<!-- endbuild -->

	<script>
		Breakpoints();
	</script>
</head>
	
<body class="menubar-top menubar-light theme-primary">
<!--============= start main area -->

<!-- APP NAVBAR ==========-->
<nav id="app-navbar" class="navbar navbar-inverse navbar-fixed-top primary">
  
  <!-- navbar header -->
  <div class="navbar-header">


    <a href="/" class="navbar-brand">
      <span class="brand-icon"><i class="fa fa-gg"></i></span>
      <span class="brand-name">우리동네 작은 도서관</span>
    </a>
  </div><!-- .navbar-header -->
  
  <div class="navbar-container container-fluid">
    <div class="collapse navbar-collapse" id="app-navbar-collapse">
      <ul class="nav navbar-toolbar navbar-toolbar-left navbar-left">
        <li class="hidden-float hidden-menubar-top">
          <a href="javascript:void(0)" role="button" id="menubar-fold-btn" class="hamburger hamburger--arrowalt is-active js-hamburger">
            <span class="hamburger-box"><span class="hamburger-inner"></span></span>
          </a>
        </li>
        <li>
          <h5 class="page-title hidden-menubar-top">Dashboard</h5>
        </li>
      </ul>

      <ul class="nav navbar-toolbar navbar-toolbar-right navbar-right">
        <li class="nav-item dropdown hidden-float">
          <a href="javascript:void(0)" data-toggle="collapse" data-target="#navbar-search" aria-expanded="false">
            <i class="zmdi zmdi-hc-lg zmdi-search"></i>
          </a>
        </li>
     </div>

      </ul>
    </div>
  </div><!-- navbar-container -->
</nav>
<!--========== END app navbar -->

<!-- APP ASIDE ==========-->
<aside id="menubar" class="menubar light">
  <div class="app-user">
    <div class="media">
    
      <div class="media-left">
      	<sec:authorize access="isAuthenticated()">
        <div class="avatar avatar-md avatar-circle">
          <a href="javascript:void(0)"><img class="img-responsive" src="/resources/assets/images/221.jpg" alt="avatar"/></a>
        </div>
        </sec:authorize>
        
        <sec:authorize access="isAnonymous()">
        	<a href="../customLogin">로그인</a>
        </sec:authorize>
        
      </div>
      
      <div class="media-body">
        <div class="foldable">
          <h5><a href="javascript:void(0)" class="username">John Doe</a></h5>
          <ul>
            <li class="dropdown">
              <a href="javascript:void(0)" class="dropdown-toggle usertitle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <small>Web Developer</small>
                <span class="caret"></span>
              </a>
              <ul class="dropdown-menu animated flipInY">
                <li>
                  <a class="text-color" href="/index.html">
                    <span class="m-r-xs"><i class="fa fa-home"></i></span>
                    <span>Home</span>
                  </a>
                </li>
                <li>
                  <a class="text-color" href="profile.html">
                    <span class="m-r-xs"><i class="fa fa-user"></i></span>
                    <span>Profile</span>
                  </a>
                </li>
                <li>
                  <a class="text-color" href="settings.html">
                    <span class="m-r-xs"><i class="fa fa-gear"></i></span>
                    <span>Settings</span>
                  </a>
                </li>
                <li role="separator" class="divider"></li>
                <li>
                  <a class="text-color" href="javascript:void(0);$('#logout').submit();">
                    <span class="m-r-xs"><i class="fa fa-power-off"></i></span>
                    <span>Logout</span>
                  </a>
                </li>
                <form id="logout" method="post" action="../customLogout">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				</form>
              </ul>
            </li>
          </ul>
        </div>
      </div><!-- .media-body -->
    </div><!-- .media -->
  </div><!-- .app-user -->

  <div class="menubar-scroll">
    <div class="menubar-scroll-inner">
      <ul class="app-menu">
        <li class="has-submenu">
          <a href="javascript:void(0)" class="submenu-toggle">
            <i class="menu-icon zmdi zmdi-view-dashboard zmdi-hc-lg"></i>
            <span class="menu-text">게시판</span>
            <i class="menu-caret zmdi zmdi-hc-sm zmdi-chevron-right"></i>
          </a>
          <ul class="submenu">
            <li><a href="/board/list"><span class="menu-text">전국</span></a></li>
            <li><a href="/news/list"><span class="menu-text">공지사항</span></a></li>            
            </ul>
        </li>
        
          <li class="has-submenu">
          <a href="/report/list" class="submenu-toggle">
            <i class="menu-icon zmdi zmdi-view-dashboard zmdi-hc-lg"></i>
            <span class="menu-text">업무보고서</span>
            <i class="menu-caret zmdi zmdi-hc-sm zmdi-chevron-right"></i>
          </a>
         </li>
 
      </ul><!-- .app-menu -->
    </div><!-- .menubar-scroll-inner -->
  </div><!-- .menubar-scroll -->
</aside>
<!--========== END app aside -->

<!-- navbar search -->
<div id="navbar-search" class="navbar-search collapse">
  <div class="navbar-search-inner">
    <form action="#">
      <span class="search-icon"><i class="fa fa-search"></i></span>
      <input class="search-field" type="search" placeholder="search..."/>
    </form>
    <button type="button" class="search-close" data-toggle="collapse" data-target="#navbar-search" aria-expanded="false">
      <i class="fa fa-close"></i>
    </button>
  </div>
  <div class="navbar-search-backdrop" data-toggle="collapse" data-target="#navbar-search" aria-expanded="false"></div>
</div><!-- .navbar-search -->

<!-- APP MAIN ==========-->
<main id="app-main" class="app-main">