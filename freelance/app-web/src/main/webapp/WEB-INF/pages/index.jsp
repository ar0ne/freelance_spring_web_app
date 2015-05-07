<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
    </head>
    <body>
        <div id="header">
            
            <c:if test="${pageContext.request.userPrincipal.name == null}">
                <a href='<spring:url value="/login" ></spring:url>'>Sign in</a>
                <a href='<spring:url value="/signUp" ></spring:url>'>Sign up</a>
            </c:if>
                
            <c:if test="${pageContext.request.userPrincipal.name != null}">
                <h2>Welcome : <c:out value="${pageContext.request.userPrincipal.name}" /> 
                    | <a href='<spring:url value="/logout" ></spring:url>'> Logout</a></h2>  
                    
                <a href='<spring:url value="${user_home}" ></spring:url>'>Your profile</a> <br/>
                    
                <a href='<spring:url value="/addVacancy" ></spring:url>'>Add vacancy</a><br/>
                    
                <a href='<spring:url value="/findJob" ></spring:url>'>Find job</a><br/>
                    
                    
            </c:if>
        </div>
        
        <c:forEach items="${users}" var="user">
            ${user.id} ${user.login} <br/>
        </c:forEach>
        
        
    </body>
</html>
