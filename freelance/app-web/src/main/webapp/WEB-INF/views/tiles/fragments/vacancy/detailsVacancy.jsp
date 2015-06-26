<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="container">

    <div class="row">

        <div class="col-md-8">

            <div id="vacancy_info" >

                <p id="error" class="bg-danger"></p>    

                <h2 class="vacancy-title">${vacancy.title}</h2>

                <div class="vacancy-info row">
                    <div class="col-md-4">
                        <p><b>Payment: </b>${vacancy.payment}</p>
                    </div>
                    <div class="col-md-5">
                        <p><b>Posted: </b>${vacancy.dateAdded}</p>
                    </div>
                    <div class="col-md-2">
                        <p><b>Author: </b><a href='<spring:url value="/user/details/${vacancy.userId}" ></spring:url>'>${vacancy.userLogin}</a></p>
                    </div>
                </div>

                <div id="add_request__form" style="display: none">

                    <table class="table">
                        <tr>
                            <td class="col-md-2">
                                <label for="Comment">Enter your message:</label>
                            </td>
                            <td class="col-md-8">
                                <textarea id="add_request_comment__input" type="text" name="Comment" class="form-control" placeholder="Add your comment"></textarea>
                            </td>
                        </tr>
                        <input type="hidden" name="vacancyId" value="${vacancy.id}"/>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
                    </table>
                    
                    <div class="pull-right">
                        <a class="btn btn-primary" href="<spring:url value='/vacancy/jr/add'></spring:url>" id="add_request__submit">Apply Job</a>
                    </div>
                    <br/>

                </div>

                <br/>


                <div class="highlight">
                    <h4>Details</h4>
                    <p>${vacancy.description}</p>
                </div>

                <br/>
                    
                <h3>Applicants</h3>

                <div id="jobRequest_table">
                    <table class="table">
                        <tr>
                            <th>Freelancer</th>
                            <th>Comment</th>
                            <th>Date applied</th>
                        </tr>

                        <c:if test="${not empty jobRequestList }">

                            <c:forEach items="${jobRequestList}" var="jobRequest">
                                <tr>
                                    <td><a href='<spring:url value="/user/details/${jobRequest.userId}" ></spring:url>'>${jobRequest.userLogin}</a></td>
                                    <td>${jobRequest.comment}</td>
                                    <td>${jobRequest.dateAdded}</td>
                                    <td style="display: none" class="jobRequest_id">${jobRequest.id}</td>
                                </tr>
                            </c:forEach>

                        </c:if>
                    </table>
                </div>

            </div>
        </div>

        <div class="col-md-4">

            <div class="row" id="right_vacancy_column">
                
                <c:choose>

                    <c:when test="${pageContext.request.userPrincipal.name == vacancy.userLogin}">
                        <button class="btn btn-info btn-block">It's your vacancy</button>
                    </c:when>

                    <c:when test="${not vacancy.status}">
                        <a class="btn btn-success btn-block" href='#' id="add_request__button">Apply To This Job</a>
                    </c:when>

                    <c:otherwise>
                        <button class="btn btn-warning btn-block">Vacancy Closed</button>
                    </c:otherwise>

                </c:choose>
                
                <br/>

            </div>                                
            
        </div>

    </div>
</div>