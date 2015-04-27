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
            <a href='<spring:url value="/sign_in" ></spring:url>'>Sign in</a>
            <a href='<spring:url value="/sign_up" ></spring:url>'>Sign up</a>
        </div>
        
        <c:forEach items="${users}" var="user">
            ${user.id} ${user.login} 
        </c:forEach>
        
        
        
    </body>
</html>
