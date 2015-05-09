<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Find Job Page</title>
    </head>
    <body>
        
        <c:if test="${pageContext.request.userPrincipal.name != null}">
            <h2>Welcome : <c:out value="${pageContext.request.userPrincipal.name}" /> 
                | <a href='<spring:url value="/logout" ></spring:url>'> Logout</a> </h2> 
                <a href='<spring:url value="/userProfile" ></spring:url>'>Your Profile</a>
        </c:if>
        
        <h1>List of vacancy:</h1>
        
        <c:if test="${not empty vacancyList}">
            <div id="vacancy_list">
                
                <c:forEach items="${vacancyList}" var="vacancy">
                    <div class="vacancy">
                        
                        <h5>${vacancy.title}</h5>
                        <p><a href="<spring:url value='/userProfile/${vacancy.userId}' ></spring:url>" >${vacancy.userLogin}</a> </p>
                        <p>${vacancy.description}</p><br/>
                        <p>Payment: ${vacancy.payment}</p><br/>
                        <p>Date: ${vacancy.dateAdded}</p><br/>
                        <a href='<spring:url value="/vacancy/${vacancy.id}" ></spring:url>'>More info...</a>
                    </div>
                    <br/>
                </c:forEach>
                
            </div>
        </c:if>
        
    </body>
</html>
