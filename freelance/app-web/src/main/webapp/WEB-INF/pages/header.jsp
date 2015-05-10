<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>" type="text/css">
        <link rel="stylesheet" href="<c:url value='/resources/css/custom.css'/>" type="text/css">
        <script src="<c:url value='/resources/js/jquery.min.js'/>" ></script>
    </head>
    <body>
        <div id="header">
            <nav class="navbar navbar-inverse navbar-fixed-top">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <c:choose>
                                <c:when test="${pageContext.request.userPrincipal.name != null}">
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </c:when>
                                <c:otherwise>
                                    <span class="icon-bar"></span>
                                </c:otherwise>
                            </c:choose>
                        </button>
                        <a class="navbar-brand" href="#">Freelance Platform</a>
                    </div>
                    <div id="navbar" class="collapse navbar-collapse">
                        <ul class="nav navbar-nav">
                            <li class="active"><a href="#">Home</a></li>
                            <li><a href="#about">About</a></li>
                            <li><a href="#contact">Contact</a></li>
                            <c:choose>
                                <c:when test="${pageContext.request.userPrincipal.name != null}">
                                    <li><a href='<spring:url value="/logout" ></spring:url>'>Logout</a></li>
                                    <li><a href="">Hi, <c:out value="${pageContext.request.userPrincipal.name}" /></a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href='<spring:url value="/login" ></spring:url>'>Login</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div><!--/.nav-collapse -->
                </div>
            </nav>
        </div>        
    </body>
</html>