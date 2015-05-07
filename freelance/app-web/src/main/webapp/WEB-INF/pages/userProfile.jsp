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
        
                                
            <c:if test="${not empty vacancyList }">

                <h4>My Vacancy</h4>
                <div id="vacancy_table">
                    <table>
                    <c:forEach items="${vacancyList}" var="vacancy">
                        <tr>
                            <td>${vacancy.title}</td>
                            <td>${vacancy.status}</td>
                            <td><a class="delete_vacancy__button" href='<spring:url value="/deleteVacancy" ></spring:url>'>Delete</a></td>
                            <td style="display: none" class="vacancy_id">${vacancy.id}</td>
                        </tr>
                    </c:forEach>
                    </table>
                </div>

            </c:if>
        
            
            <br/>    
                
            <a href='<spring:url value="/findJob" ></spring:url>'>Find job</a><br/>

            <a href='<spring:url value="/addVacancy" ></spring:url>'>Add vacancy</a>            
 
            
        </c:if>
            
        <script src="<c:url value='/resources/js/jquery.min.js'/>" ></script>
        <script src="<c:url value='/resources/js/user_profile.js'/>" ></script>
        
    </body>
</html>
