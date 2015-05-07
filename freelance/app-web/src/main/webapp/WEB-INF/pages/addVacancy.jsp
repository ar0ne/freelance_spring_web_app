<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Vacancy Page</title>
    </head>
    <body>
        <h3>Enter what worker do you need.</h3>
        
        <div id="add_vacancy_form">        
            <form action="submitNewVacancy" method="post">
                <table>
                    <tr>
                        <td>
                            <label for="title">Title: </label>
                        </td>
                        <td>
                            <input type="text" name="title" /><br/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="description">Description: </label>
                        </td>
                        <td>
                            <input type="text" name="description" /><br/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="payment">Payment: </label>
                        </td>
                        <td>
                            <input type="text" name="payment" /><br/>
                        </td>
                    </tr>
                    <tr>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" value="Add"/>
                        </td>
                    </tr>

                </table>
            </form>
        </div>
    </body>
</html>
