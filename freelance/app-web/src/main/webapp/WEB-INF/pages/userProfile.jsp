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
        <title>User profile</title>
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
                

        <div id="container" class="container theme-showcase" role="main" >

            <div id="user_profile" >

                <div class="row">
                    <div class="col-md-4">
                        <img src="<c:url value='/resources/images/avatar.png'/>" alt="Your avatar" class="img-rounded img-responsive">
                    </div>
                    <div class="col-md-6">

                        <div id="user_profile_form">

                            <table class="table table-condensed">
                                <tbody>
                                    <tr>
                                        <td>ID</td><td>${user.id}</td>
                                    </tr>
                                    <tr>
                                        <td>Name</td><td>${user.name}</td>
                                    </tr>
                                    <tr>
                                        <td>Login</td><td>${user.login}</td>
                                    </tr>
                                    <tr>
                                        <td>About</td><td>${user.about}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    
                        <c:if test="${pageContext.request.userPrincipal.name == user.login}" >
                            
                            <a href="#" class="btn btn-default" role="button" id="update_profile__button">Update Profile</a>
                               
                            <div id="update_profile_form" style="display:none">  

                                <form action="<spring:url value="/userProfile/submitUpdateUserProfile" ></spring:url>" method="post">
                                    <table class="table">
                                        <tr>
                                            <td>
                                                <label for="name">Name:</label>
                                            </td>
                                            <td>
                                                <input type="text" name="name" value="${user.name}" class="form-control"/><br/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label for="login">Login:</label>
                                            </td>
                                            <td>
                                                <input type="text" name="login" value="${user.login}" class="form-control"/><br/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label for="password">Password:</label>
                                            </td>
                                            <td>
                                                <input type="text" name="password" value="${user.password}" class="form-control"/><br/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label for="about">About</label>
                                            </td>
                                            <td>
                                                <textarea class="form-control" rows="3" name="about">${user.about}</textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <input type="hidden" name="id" value="${user.id}"/><br/>
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                        </tr>
                                        <tr>
                                            <td>
                                                <button type="submit" class="btn btn-success">Update</button>
                                            </td>
                                        </tr>

                                    </table>

                                </form>
                            </div>
                        </c:if>
                    </div>

                </div>
            </div>
                        
            <c:if test="${pageContext.request.userPrincipal.name == user.login}" >

                <c:choose>
                    
                    <c:when test="${isAdmin}">

                        <c:if test="${not empty userList}">

                            <br/>
                            <h4>Table of users</h4>
                            <div id="users_table">
                                <table class="table table-bordered table-striped table-hover">
                                    <tr>
                                        <th>ID</th>
                                        <th>Login</th>
                                        <th>Name</th>
                                        
                                        <th>URL</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    <c:forEach items="${userList}" var="user">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td>${user.login}</td>
                                            <td>${user.name}</td>
                                            <td><a href='<spring:url value="/userProfile/${user.id}" ></spring:url>'>See profile</a></td>
                                            <td class="user_status">${user.enabled}</td>
                                            <td style="display: none" class="user_id">${user.id}</td>
                                            <td><a href='<spring:url value="/userProfile/changeUserStatus" ></spring:url>' class="change_user_status__button">Change status</a></td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                        </c:if> 

                    </c:when>

                    <c:otherwise>
                        <br/>
                        <div role="tabpanel">

                            <ul class="nav nav-tabs" role="tablist">
                                <c:if test="${not empty myVacancyList }">
                                    <li role="presentation" class="active"><a href="#vacancy_table" aria-controls="vacancy_table" role="tab" data-toggle="tab">My Vacancys</a></li>
                                </c:if>
                                <c:if test="${not empty myJobRequestList }">
                                  <li role="presentation"><a href="#jobRequest_table" aria-controls="profile" role="tab" data-toggle="tab">My Job Requests</a></li>
                                </c:if>
                            </ul>


                        <div class="tab-content">

                            <c:if test="${not empty myVacancyList }">

                                <div role="tabpanel" class="tab-pane active" id="vacancy_table">

                                        <c:set var="count" value="0" scope="page" />

                                        <c:forEach items="${myVacancyList}" var="vacancy">

                                            <c:set var="count" value="${count + 1}" scope="page"/>

                                            <div id="vacancy_${count}">

                                                <table class="table table-bordered table-hover table-condensed" style="margin-bottom: 0">
                                                    <tr>
                                                        <th>Vacancy #</th>
                                                        <th>Title</th>
                                                        <th>Payment</th>
                                                        <th>Date added</th>
                                                        <th>URL</th>
                                                        <th>Status</th>
                                                        <th>Action</th>
                                                    </tr>
                                                    <tr>
                                                        <td>${count}</td>
                                                        <td>${vacancy.title}</td>
                                                        <td>${vacancy.payment}</td>
                                                        <td>${vacancy.dateAdded}</td>
                                                        <td><a href='<spring:url value="/vacancy/${vacancy.id}" ></spring:url>'>See</a></td>
                                                        <td>${vacancy.status}</td>
                                                        <td><a class="delete_vacancy__button" href='<spring:url value="/deleteVacancy" ></spring:url>'>Delete</a></td>
                                                        <td style="display: none" class="vacancy_id">${vacancy.id}</td>
                                                    </tr>
                                                    <c:if test="${not empty vacancy.jobRequests }">
                                                        </table>
                                                    </c:if>
                                                    <c:if test="${not empty vacancy.jobRequests }">
                                                        <table class="table table-bordered">
                                                            <c:forEach items="${vacancy.jobRequests}" var="request">
                                                                <tr class="success">
                                                                    <th>User</th>
                                                                    <th>Comment</th>
                                                                    <th>Date added</th>
                                                                    <th>Status</th>
                                                                    <c:if test="${not request.status}">
                                                                        <th>Action</th>
                                                                    </c:if>
                                                                </tr>
                                                                <tr>
                                                                    <td><a href='<spring:url value="/userProfile/${request.userId}" ></spring:url>'>${request.userLogin}</a></td>
                                                                    <td>${request.comment}</td>
                                                                    <td>${request.dateAdded}</td>
                                                                    <td>${request.status}</td>
                                                                    <c:if test="${not request.status}">
                                                                        <td style="display: none" class="request_id">${request.id}</td>
                                                                        <td style="display: none" class="vacancy_id">${vacancy.id}</td>
                                                                        <td><a href='<spring:url value="/acceptRequest" ></spring:url>' class="accept_job_request__button">Accept</a></td>
                                                                    </c:if>
                                                                </tr>
                                                            </c:forEach>
                                                        </table>
                                                    </c:if>
                                                    <c:if test="${empty vacancy.jobRequests }">
                                                        </table>
                                                    </c:if>
                                            </div>
                                            
                                        </c:forEach>

                                    </table>
                                </div>

                            </c:if>

                            <c:if test="${not empty myJobRequestList }">

                                <div role="tabpanel" class="tab-pane" id="jobRequest_table">
                                    <table class="table table-bordered table-hover table-condensed">
                                        <c:forEach items="${myJobRequestList}" var="jobRequest">
                                            <tr>
                                                <th>Comment</th>
                                                <th>Date added</th>
                                                <th>URL</th>
                                                <th>Status</th>
                                            </tr>
                                            <tr>
                                                <td>${jobRequest.comment}</td>
                                                <td>${jobRequest.dateAdded}</td>
                                                <td><a href='<spring:url value="/vacancy/${jobRequest.vacancyId}" ></spring:url>'>See</a></td>
                                                <td>${jobRequest.status}</td>
                                                <td style="display: none" class="jobRequest_id">${jobRequest.id}</td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </div>

                            </c:if>

                        </div>
                        
                    </c:otherwise>

                </c:choose>                    
                
                
            </c:if>

        </div>
            
        <script src="<c:url value='/resources/js/jquery.min.js'/>" ></script>
        <script src="<c:url value='/resources/js/bootstrap.min.js'/>" ></script>
        <script src="<c:url value='/resources/js/user_profile.js'/>" ></script>
        
    </body>
</html>
