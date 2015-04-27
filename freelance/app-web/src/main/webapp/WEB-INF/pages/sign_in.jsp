<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign In Page</title>
    </head>
    <body>
                
        <form action="submitDataSignIn" method="post">
            <table>
                <tr>
                    <td>
                        <label for="Login">Login</label>
                    </td>
                    <td>
                        <input type="text" name="Login"/><br/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label for="Password">Password</label>
                    </td>
                    <td>
                        <input type="password" name="Password"/><br/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" value="Submit"/>
                    </td>
                </tr>
                
            </table>
        </form>
    </body>
</html>
