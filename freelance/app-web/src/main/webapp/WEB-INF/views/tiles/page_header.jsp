<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<div id="header">
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <c:choose>
                        <c:when test="${pageContext.request.userPrincipal.name != null}">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </c:when>
                        <c:otherwise>
                            <span class="icon-bar"></span>
                        </c:otherwise>
                    </c:choose>
                </button>
                <a class="navbar-brand" href='<spring:url value="/index" ></spring:url>'>Freelance Platform</a>
            </div>
            <div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="<spring:url value='/userProfile' ></spring:url>">Home</a></li>
                    <c:choose>
                        <c:when test="${pageContext.request.userPrincipal.name != null}">
                            <li><a href='<spring:url value="/addVacancy" ></spring:url>'>Add vacancy</a></li> 
                            <li><a href='<spring:url value="/findJob" ></spring:url>'>Find Job</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="<spring:url value="/userProfile" ></spring:url>">Hi, <c:out value="${pageContext.request.userPrincipal.name}" /></a></li>
                            <li><a href='<spring:url value="/logout" ></spring:url>'>Logout</a></li>
                        </ul>
                        </c:when>
                        <c:otherwise>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href='<spring:url value="/login" ></spring:url>'>Login</a></li>
                                <li><a href='<spring:url value="/signUp" ></spring:url>' >Sign Up</a></li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </nav>
</div> 