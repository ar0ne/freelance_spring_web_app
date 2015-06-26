<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="container" id="container">

    <div class="row">
        <h3>Recommended Jobs</h3>
        
        <c:if test="${not empty vacancyList}">
            <div id="vacancy_list">
                <c:forEach items="${vacancyList}" var="vacancy">
                    <div class="vacancy">
                        <h3><a class="vacancy-title" href='<spring:url value="/vacancy/${vacancy.id}" ></spring:url>'>${vacancy.title}</a></h3>
                        <p><b>Payment</b> - ${vacancy.payment}&nbsp;&nbsp;|&nbsp;&nbsp;<b>Posted:</b> ${vacancy.dateAdded}</p>
                        <p>${vacancy.description}  <span class="more_info"><a href='<spring:url value="/vacancy/${vacancy.id}" ></spring:url>'>more</a></span></p>
                        <p><b>Author:</b> <a href="<spring:url value='/user/details/${vacancy.userId}' ></spring:url>" >${vacancy.userLogin}</a></p>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
</div>