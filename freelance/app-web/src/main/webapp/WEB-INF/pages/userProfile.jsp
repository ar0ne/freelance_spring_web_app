<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Profile Page</title>
    </head>
    <body>
        <h1>User Profile Page!</h1>
        
        <table>
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
                    <td>Password</td><td>${user.password}</td>
                </tr>
            </tbody>
        </table>
                
    </body>
</html>
