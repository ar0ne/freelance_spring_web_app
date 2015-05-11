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
                

        <div id="container" class="container" role="main" >

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
                                        <th>Page</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    <c:forEach items="${userList}" var="user">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td>${user.login}</td>
                                            <td>${user.name}</td>
                                            <td><a href='<spring:url value="/userProfile/${user.id}" ></spring:url>'>See profile</a></td>
                                            <td class="user-status"><button class="btn">${user.enabled}</button></td>
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

                        <c:if test="${not empty myVacancyList or not empty myJobRequestList }">

                            <div role="tabpanel">

                                <ul class="nav nav-tabs" role="tablist">
                                    <c:if test="${not empty myVacancyList }">
                                        <li role="presentation" class="active"><a href="#vacancy_table" aria-controls="vacancy_table" role="tab" data-toggle="tab">My Vacancys</a></li>
                                    </c:if>
                                    <c:if test="${not empty myJobRequestList }">
                                      <li role="presentation"><a href="#jobRequest_table" aria-controls="profile" role="tab" data-toggle="tab">My Job Requests</a></li>
                                    </c:if>
                                </ul>

                            </div>

                        </c:if>


                        <div class="tab-content">

                            <c:if test="${not empty myVacancyList }">

                                <div role="tabpanel" class="tab-pane active" id="vacancy_table">

                                    <c:set var="count" value="0" scope="page" />

                                    <c:forEach items="${myVacancyList}" var="vacancy">

                                        <c:set var="count" value="${count + 1}" scope="page"/>

                                        <div id="vacancy_${count}" class="vacancy">

                                            <div class="row">
                                                <div class="col-md-7">
                                                    <div class="row">
                                                        <div class="col-md-2 vacancy-status">
                                                            <button class="btn" id="vacancy_status__button${vacancy.id}">${vacancy.status}</button>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <a href='<spring:url value="/vacancy/${vacancy.id}" ></spring:url>' class="user-vacancy-title">${vacancy.title}</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <p><b>payment: </b>${vacancy.payment}</p>
                                                    <p><b>Date added: </b>${vacancy.dateAdded}</p>
                                                    <div style="display: none" class="vacancy_id">${vacancy.id}</div>
                                                    <a class="delete_vacancy__button btn btn-danger" href='<spring:url value="/deleteVacancy" ></spring:url>'>Delete</a>
                                                </div>
                                            </div>
                                            <c:if test="${not empty vacancy.jobRequests }">
                                                <h4>Applicants</h4>
                                                <c:forEach items="${vacancy.jobRequests}" var="request">
                                                    <div class="row table-applicants<c:if test='${request.status}'> bg-success</c:if>">
                                                        <div class="col-md-1">
                                                            <a href='<spring:url value="/userProfile/${request.userId}" ></spring:url>'><img src="<c:url value='/resources/images/avatar.png'/>" alt="${request.userLogin}" class="img-circle img-responsive small-user-avatar"></a>
                                                            <p style="text-align: center;"><a href='<spring:url value="/userProfile/${request.userId}" ></spring:url>'>${request.userLogin}</a></p>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <p>${request.comment}</p>
                                                            <p>${request.dateAdded}</p>
                                                        </div>
                                                        <c:if test="${not request.status}">
                                                            <div class="col-md-4">
                                                                <span style="display: none" class="request_id">${request.id}</span>
                                                                <span style="display: none" class="vacancy_id">${vacancy.id}</span>
                                                                <c:if test="${not vacancy.status}" >
                                                                    <a href='<spring:url value="/acceptRequest" ></spring:url>' class="accept_job_request__button btn btn-success">Accept</a>
                                                                </c:if>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                    
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </div>

                            </c:if>

                            <c:if test="${not empty myJobRequestList }">

                                <div role="tabpanel" class="tab-pane" id="jobRequest_table">
                                    <table class="table table-bordered table-hover table-condensed">
                                        <tr>
                                            <th>Comment</th>
                                            <th>Date added</th>
                                            <th>Status</th>
                                        </tr>
                                        <c:forEach items="${myJobRequestList}" var="jobRequest">
                                            <tr>
                                                <td><a href='<spring:url value="/vacancy/${jobRequest.vacancyId}" ></spring:url>'>${jobRequest.comment}</a></td>
                                                <td>${jobRequest.dateAdded}</td>
                                                <td class="job-request-status"><button class="btn">${jobRequest.status}</button></td>
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
    </div>

        <footer class="footer">
            <p>Freelance Platform by <a href="http://github.com/ar0ne/">Serj Ar[]ne</a></p>
            <p><small>2015</small></p>
        </footer>
            
        <script src="<c:url value='/resources/js/jquery.min.js'/>" ></script>
        <script src="<c:url value='/resources/js/bootstrap.min.js'/>" ></script>
        <script src="<c:url value='/resources/js/user_profile.js'/>" ></script>
        
    </body>
</html>
