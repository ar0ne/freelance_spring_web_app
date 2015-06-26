<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div id="container" class="container">
            
    <div id="add_vacancy_form">     

        <h3>Add your vacancy</h3><br/>

        <form action="<spring:url value='/vacancy/add' ></spring:url>" method="POST">

            <label for="title">Title: </label>
            <input type="text" name="title" class="form-control" maxlength="255" minlength="2" required autofocus /><br/>
       
            <label for="payment" >Payment: </label>
            <input type="text" name="payment" class="form-control" /><br/>
        
            <label for="description" >Description: </label>
            <textarea class="form-control" rows="3" name="description" class="form-control" maxlength="3000" minlength="5" required></textarea>
        
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <br/>
            <button type="submit" class="btn btn-success">Add</button>

        </form>
    </div>

</div>