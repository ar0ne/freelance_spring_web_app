<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <title>User Profile Page</title>
    </head>
    <body>
        <h1>User Profile Page!</h1>
        
        <c:if test="${pageContext.request.userPrincipal.name != null}">
		<h2>Welcome : <c:out value="${pageContext.request.userPrincipal.name}" /> 
                 | <a href='<spring:url value="/logout" ></spring:url>'> Logout</a> </h2>  
	</c:if>
                
        <div id="user_profile" >
            <table>
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
                        <td>Password</td><td>${user.password}</td>
                    </tr>
                    <tr>
                        <td>About</td><td>${user.about}</td>
                    </tr>
                </tbody>
            </table>
        </div>
                    
        <c:if test="${pageContext.request.userPrincipal.name == user.login}" >
            
            <a href="#" id="update_profile__button">Update Profile</a>
               
            <div id="update_profile_form" style="display:none">        
                <form action="<spring:url value="/userProfile/submitUpdateUserProfile" ></spring:url>" method="post">
                    <table>
                        <tr>
                            <td>
                                <label for="name">Name:</label>
                            </td>
                            <td>
                                <input type="text" name="name" value="${user.name}"/><br/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="login">Login:</label>
                            </td>
                            <td>
                                <input type="text" name="login" value="${user.login}"/><br/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="password">Password:</label>
                            </td>
                            <td>
                                <input type="password" name="password" value="${user.password}"/><br/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label for="about">About</label>
                            </td>
                            <td>
                                <input type="text" name="about" value="${user.about}"/><br/>
                            </td>
                        </tr>
                        <tr>
                            <input type="hidden" name="id" value="${user.id}"/><br/>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </tr>
                        <tr>
                            <td>
                                <input type="submit" value="Update"/>
                            </td>
                        </tr>

                    </table>
                </form>
            </div>
        
            <c:choose>
                
                <c:when test="${isAdmin}">

                    <c:if test="${not empty userList}">

                        <h4>Table of users</h4>
                        <div id="users_table">
                            <table>
                                <tr>
                                    <th>ID</th>
                                    <th>Login</th>
                                    <th>Name</th>
                                    <th>Status</th>
                                    <th>URL</th>
                                </tr>
                                <c:forEach items="${userList}" var="user">
                                    <tr>
                                        <td>${user.id}</td>
                                        <td>${user.login}</td>
                                        <td>${user.name}</td>
                                        <td>${user.enabled}</td>
                                        <td><a href='<spring:url value="/userProfile/${user.id}" ></spring:url>'>See profile</a></td>
                                        </tr>
                                </c:forEach>
                            </table>
                        </div>
                    </c:if> 

                </c:when>

                <c:otherwise>

                    <c:if test="${not empty myVacancyList }">

                        <h4>My Vacancy</h4>
                        <div id="vacancy_table">
                            <table>
                                <c:forEach items="${myVacancyList}" var="vacancy">
                                    <tr>
                                        <td><a href='<spring:url value="/vacancy/${vacancy.id}" ></spring:url>'>Go to</a></td>
                                        <td>${vacancy.title}</td>
                                        <td>${vacancy.status}</td>
                                        <td><a class="delete_vacancy__button" href='<spring:url value="/deleteVacancy" ></spring:url>'>Delete</a></td>
                                        <td style="display: none" class="vacancy_id">${vacancy.id}</td>
                                    </tr>
                                    <c:if test="${not empty vacancy.jobRequests }">
                                        <c:forEach items="${vacancy.jobRequests}" var="request">
                                            <table>
                                                <tr>
                                                    <td>${request.dateAdded}</td>
                                                    <td>${request.comment}</td>
                                                    <td>${request.status}</td>
                                                    <c:if test="${not request.status}">
                                                        <td style="display: none" class="request_id">${request.id}</td>
                                                        <td><a href='<spring:url value="/acceptRequest" ></spring:url>' class="accept_job_request__button">Accept</a></td>
                                                    </c:if>
                                                </tr>
                                            </table>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </table>
                        </div>

                    </c:if>



                    <c:if test="${not empty myJobRequestList }">

                        <h4>My JobRequests</h4>
                        <div id="jobRequest_table">
                            <table>
                                <c:forEach items="${myJobRequestList}" var="jobRequest">
                                    <tr>
                                        <td>${jobRequest.dateAdded}</td>
                                        <td>${jobRequest.comment}</td>
                                        <td>${jobRequest.status}</td>
                                        <td style="display: none" class="jobRequest_id">${jobRequest.id}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </div>

                    </c:if>


                    <br/>    

                    <a href='<spring:url value="/findJob" ></spring:url>'>Find job</a><br/>

                        <a href='<spring:url value="/addVacancy" ></spring:url>'>Add vacancy</a>            

                </c:otherwise>

            </c:choose>                    
            
            
        </c:if>
            
        <script src="<c:url value='/resources/js/jquery.min.js'/>" ></script>
        <script src="<c:url value='/resources/js/user_profile.js'/>" ></script>
        
    </body>
</html>
