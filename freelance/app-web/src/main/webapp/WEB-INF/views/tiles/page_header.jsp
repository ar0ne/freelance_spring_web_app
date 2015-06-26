<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page isELIgnored="false"%>

<div id="header">
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <sec:authorize access="isAuthenticated()">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </sec:authorize>
                    <sec:authorize access="isAnonymous()">
                        <span class="icon-bar"></span>
                    </sec:authorize>
                </button>
                <a class="navbar-brand" href='<spring:url value="/index" ></spring:url>'>Freelance Platform</a>
            </div>
            <div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="<spring:url value='/user/details' ></spring:url>">Home</a></li>
                    <sec:authorize access="isAuthenticated()">
                            <li><a href='<spring:url value="/vacancy/add" ></spring:url>'>Add vacancy</a></li> 
                            <li><a href='<spring:url value="/vacancy/list" ></spring:url>'>Find Job</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href='<spring:url value="/user/details" ></spring:url>'>Hi, <c:out value="${pageContext.request.userPrincipal.name}" /></a></li>
                            <li><a href='<spring:url value="/user/logout" ></spring:url>'>Logout</a></li>
                        </ul>
                    </sec:authorize>
                    <sec:authorize access="isAnonymous()">
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href='<spring:url value="/user/login" ></spring:url>'>Login</a></li>
                            <li><a href='<spring:url value="/user/sign_up" ></spring:url>' >Sign Up</a></li>
                        </ul>
                    </sec:authorize>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </nav>
</div> 