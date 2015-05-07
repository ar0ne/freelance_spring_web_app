<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vacancy Page</title>
    </head>
    <body>
        <c:if test="${pageContext.request.userPrincipal.name != null}">
		<h2>Welcome : <c:out value="${pageContext.request.userPrincipal.name}" /> 
                 | <a href='<spring:url value="/logout" ></spring:url>'> Logout</a> </h2>  
	</c:if>
        
        <div id="vacancy_info" >
            <table>
                <tbody>
                    <tr>
                        <td>Title</td><td>${vacancy.title}</td>
                    </tr>
                    <tr>
                        <td>Author: </td><td><a href='<spring:url value="/userProfile/${vacancy_user.id}" ></spring:url>'>${vacancy_user.login}</a></td>
                    </tr>
                    <tr>
                        <td>Payment</td><td>${vacancy.payment}</td>
                    </tr>
                    <tr>
                        <td>Date: </td><td>${vacancy.dateAdded}</td>
                    </tr>
                    <tr>
                        <td>Description: </td><td>${vacancy.description}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        
    </body>
</html>
