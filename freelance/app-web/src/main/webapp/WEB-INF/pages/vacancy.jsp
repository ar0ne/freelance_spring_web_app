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
        <title>Vacancy</title>
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
                                    <li><a href='<spring:url value="/findJob" ></spring:url>'>Find Job</a></li>
                                </ul>
                                <ul class="nav navbar-nav navbar-right">
                                    <li><a href="<spring:url value="/userProfile" ></spring:url>">Hi, <c:out value="${pageContext.request.userPrincipal.name}" /></a></li>
                                    <li><a href='<spring:url value="/logout" ></spring:url>'>Logout</a></li>
                                </ul>
                                </c:when>
                                <c:otherwise>
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

        <div class="container">

            <div class="row">

                <div class="col-md-8">

                    <div id="vacancy_info" >

                        <p id="error" class="bg-danger"></p>    

                        <h2 class="vacancy-title">${vacancy.title}</h2>

                        <div class="vacancy-info row">
                            <div class="col-md-4">
                                <p><b>Payment: </b><c:if test="${not vacancy.payment}" >Not aviable</c:if></p>
                            </div>
                            <div class="col-md-5">
                                <p><b>Posted: </b>${vacancy.dateAdded}</p>
                            </div>
                            <div class="col-md-2">
                                <p><b>Author: </b><a href='<spring:url value="/userProfile/${vacancy.userId}" ></spring:url>'>${vacancy.userLogin}</a></p>
                            </div>
                        </div>

                        <div id="add_request__form" style="display: none">

                            <table class="table">
                                <tr>
                                    <td class="col-md-2">
                                        <label for="Comment">Enter your message:</label>
                                    </td>
                                    <td class="col-md-8">
                                        <textarea id="add_request_comment__input" type="text" name="Comment" class="form-control" placeholder="Add your comment"></textarea>
                                    </td>
                                </tr>
                                <input type="hidden" name="vacancyId" value="${vacancy.id}"/>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
                            </table>
                            
                            <div class="pull-right">
                                <a class="btn btn-primary" href="<spring:url value="/addJobRequest"></spring:url>" id="add_request__submit">Apply Job</a>
                            </div>
                            <br/>

                        </div>

                        <br/>


                        <div class="highlight">
                            <h4>Details</h4>
                            <p>${vacancy.description}</p>
                        </div>

                        <br/>
                            
                        <h3>Applicants</h3>

                        <div id="jobRequest_table">
                            <table class="table">
                                <tr>
                                    <th>Freelancer</th>
                                    <th>Comment</th>
                                    <th>Date applied</th>
                                </tr>

                                <c:if test="${not empty jobRequestList }">

                                    <c:forEach items="${jobRequestList}" var="jobRequest">
                                        <tr>
                                            <td><a href='<spring:url value="/userProfile/${jobRequest.userId}" ></spring:url>'>${jobRequest.userLogin}</a></td>
                                            <td>${jobRequest.comment}</td>
                                            <td>${jobRequest.dateAdded}</td>
                                            <td style="display: none" class="jobRequest_id">${jobRequest.id}</td>
                                        </tr>
                                    </c:forEach>

                                </c:if>
                            </table>
                        </div>

                        
                            
                    </div>
                </div>

                <div class="col-md-4">

                    <div class="row" id="right_vacancy_column">
                        
                        <c:choose>

                            <c:when test="${pageContext.request.userPrincipal.name == vacancy.userLogin}">
                                <button class="btn btn-info btn-block">It's your vacancy</button>
                            </c:when>

                            <c:when test="${not vacancy.status}">
                                <a class="btn btn-success btn-block" href='#' id="add_request__button">Apply To This Job</a>
                            </c:when>

                            <c:otherwise>
                                <button class="btn btn-warning btn-block">Vacancy Closed</button>
                            </c:otherwise>

                        </c:choose>
                        
                        <br/>

                    </div>                                
                    
                </div>

            </div>
        </div>


        <footer class="footer">
            <p>Freelance Platform by <a href="http://github.com/ar0ne/">Serj Ar[]ne</a></p>
            <p><small>2015</small></p>
        </footer>
            
        <script src="<c:url value='/resources/js/jquery.min.js'/>" ></script>
        <script src="<c:url value='/resources/js/vacancy.js'/>" ></script>
        
    </body>
</html>
