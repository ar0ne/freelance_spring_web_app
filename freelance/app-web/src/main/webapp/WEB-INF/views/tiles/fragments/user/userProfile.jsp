<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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

                            <form action="<spring:url value='/userProfile/submitUpdateUserProfile' ></spring:url>" method="post">
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

            <sec:authorize access="hasRole('ROLE_ADMIN')">

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

            </sec:authorize>

                <sec:authorize access="hasRole('ROLE_USER')">
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
                
            </sec:authorize>

        </c:if>

    </div>
</div>