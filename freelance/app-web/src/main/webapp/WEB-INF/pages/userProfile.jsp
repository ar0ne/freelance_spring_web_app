<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Profile Page</title>
    </head>
    <body>
        <h1>User Profile Page!</h1>
        
        <a href="#" id="update_profile__button">Update Profile</a>
        
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
               
        <div id="update_profile_form" style="display:none">        
            <form action="submitUpdateUserProfile" method="post">
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
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" value="Update"/>
                        </td>
                    </tr>

                </table>
            </form>
        </div>
                    
        <c:if test="${not empty userList}">
            <h4>Table of users</h4>
            <div id="users_table">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Login</th>
                        <th>Name</th>
                        <th>URL</th>
                    </tr>
                <c:forEach items="${userList}" var="user">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.login}</td>
                        <td>${user.name}</td>
                        <td><a href='<spring:url value="/userProfile/${user.id}" ></spring:url>'>See profile</a></td>
                    </tr>
                </c:forEach>
                </table>
            </div>
        </c:if>
            
        <c:if test="${not empty vacancyList}">
            <h4>My Vacancy</h4>
            <div id="vacancy_table">
                <table>
                <c:forEach items="${vacancyList}" var="vacancy">
                    <tr>
                        <td>${vacancy.title}</td>
                        <td>${vacancy.status}</td>
                    </tr>
                </c:forEach>
                </table>
            </div>
        </c:if>
        
        <c:if test="${empty userList}">
            
            <a href='${userId}/find_job'>Find job</a><br/>

            <a href='${userId}/add_vacancy'>Add vacancy</a>            
        
        </c:if>         
            
        <script src="<c:url value='/resources/js/jquery.min.js'/>" ></script>
        <script type="text/javascript" src="<c:url value='/resources/js/user_profile.js'/>" ></script>
        
    </body>
</html>
