<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="_csrf" content="${_csrf.token}"/>
        <meta name="_csrf_header" content="${_csrf.headerName}"/>
        <title>Vacancy Page</title>
    </head>
    <body>
        <c:if test="${pageContext.request.userPrincipal.name != null}">
		<h2>Welcome : <c:out value="${pageContext.request.userPrincipal.name}" /> 
                 | <a href='<spring:url value="/logout" ></spring:url>'> Logout</a> </h2>  
                 <a href='<spring:url value="/userProfile" ></spring:url>'>Your Profile</a>
	</c:if>
        
        <a href='<spring:url value="/findJob" ></spring:url>'>All vacancys</a> <br/>
        
        <div id="vacancy_info" >
            <table>
                <tbody>
                    <tr>
                        <td>Title: </td><td>${vacancy.title}</td>
                    </tr>
                    <tr>
                        <td>Author: </td><td><a href='<spring:url value="/userProfile/${vacancy.userId}" ></spring:url>'>${vacancy.userLogin}</a></td>
                    </tr>
                    <tr>
                        <td>Payment: </td><td>${vacancy.payment}</td>
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
                    
        
        <h3 id="error" style="color: red"></h3>             
        
        <c:if test="${not empty jobRequestList }">
            
            <p> Job Request from users </p>

            <div id="jobRequest_table">
                <table>
                    <c:forEach items="${jobRequestList}" var="jobRequest">
                        <tr>
                            <td>Author: <a href='<spring:url value="/userProfile/${jobRequest.userId}" ></spring:url>'>${jobRequest.userLogin}</a></td>
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
        
        <a href='#' id="add_request__button">Add Request</a><br/>
        
        <div id="add_request__form" style="display: none">
            <table>
                <tr>
                    <td>
                        <label for="Comment">Enter your message:</label>
                    </td>
                    <td>
                        <input id="add_request_comment__input" type="text" name="Comment"/><br/>
                    </td>
                </tr>
                <input type="hidden" name="vacancyId" value="${vacancy.id}"/>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
            </table>
            <a href="<spring:url value="/addJobRequest" ></spring:url>" id="add_request__submit">Submit</a><br/>
        </div>
            
        <script src="<c:url value='/resources/js/jquery.min.js'/>" ></script>
        <script src="<c:url value='/resources/js/vacancy.js'/>" ></script>
        
    </body>
</html>
