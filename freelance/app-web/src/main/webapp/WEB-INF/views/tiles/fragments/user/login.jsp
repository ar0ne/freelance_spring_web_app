<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="container" id="container">

    <form class="form-signin" name='loginForm' action="<c:url value='/user/login' />" method='POST'>
        <h2 class="form-signin-heading">Login and let's go!</h2>
        <br/>
        <label for="username" class="sr-only">Login</label>
        <input type="text" name='username' id="username" class="form-control" placeholder="Login" maxlength="100" minlength="3" required autofocus>
        <br/>
        <label for="password" class="sr-only">Password</label>
        <input type="password" name='password' id="password" class="form-control" placeholder="Password" maxlength="100" minlength="3" required>

        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> Remember me
            </label>
        </div>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="msg">${msg}</div>
        </c:if>

        <input type="hidden" name="${_csrf.parameterName}"
               value="${_csrf.token}" />
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    </form>

</div> <!-- /container -->