<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>" type="text/css">
        <link rel="stylesheet" href="<c:url value='/resources/css/custom.css'/>" type="text/css">
        <title>My Job Feed</title>
    </head>
    <body>
        
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
                            <li><a href="<spring:url value='/userProfile' ></spring:url>">Home</a></li>
                            <c:choose>
                                <c:when test="${pageContext.request.userPrincipal.name != null}">
                                    <li><a href='<spring:url value="/addVacancy" ></spring:url>'>Add vacancy</a></li> 
                                    <li class="active"><a href='<spring:url value="/findJob" ></spring:url>'>Find Job</a></li>
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
        
        <div class="container" id="container">

            <div class="row">
                <h3>Recommended Jobs</h3>
                
                <c:if test="${not empty vacancyList}">
                    <div id="vacancy_list">
                        <c:forEach items="${vacancyList}" var="vacancy">
                            <div class="vacancy">
                                <h3><a class="vacancy-title" href='<spring:url value="/vacancy/${vacancy.id}" ></spring:url>'>${vacancy.title}</a></h3>
                                <p><b>Payment</b> - <c:if test="${not vacancy.payment}" >Not aviable</c:if> - Posted ${vacancy.dateAdded}</p>
                                <p>${vacancy.description}  <span class="more_info"><a href='<spring:url value="/vacancy/${vacancy.id}" ></spring:url>'>more</a></span></p>
                                <p><b>Author:</b> <a href="<spring:url value='/userProfile/${vacancy.userId}' ></spring:url>" >${vacancy.userLogin}</a></p>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>

        <footer class="footer">
            <p>Freelance Platform by <a href="http://github.com/ar0ne/">Serj Ar[]ne</a></p>
            <p><small>2015</small></p>
        </footer>
        
    </body>
</html>
