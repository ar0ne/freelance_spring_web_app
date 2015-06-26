<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="container" id="container" >
    <form class="form-signup" action="<c:url value='/user/sign_up' />" method="POST">
        <h2 class="form-signup-heading">Register new user</h2>

        <label for="Name" class="sr-only">Name</label>
        <input type="text" name='Name' class="form-control" placeholder="Name" maxlength="100" minlength="2" required autofocus>

        <label for="Login" class="sr-only">Password</label>
        <input type="text" name='Login' class="form-control" placeholder="Login" maxlength="25" minlength="3" required>

        <label for="Password" class="sr-only">Password</label>
        <input type="password" name='Password' class="form-control" placeholder="Password" maxlength="100" minlength="3" required>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> 
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign up</button>

    </form>
</div>