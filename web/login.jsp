<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script type='text/javascript'>

        var validate = function () {
            var email = document.getElementById('email').value;
            var reg = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
            if (reg.test(email) == false)
            {
                document.getElementById('email').setCustomValidity('Invalid Email Address');
            }
            else
            {
                document.getElementById('email').setCustomValidity('');
            }
        }
        </script>
    </head>
    <body>
        <div class="container">
            <div class="box">
                <img class="avatar" src="img/user-avatar.png">
                <h1>Login Account</h1>
                <form action="LoginServlet" method="post">
                    <input type="text" placeholder="Email Address" id="email" name="EmailAdd" onkeyup="validate()" required />
                    <input type="password" placeholder="Password" name="Password" required />
                    <input type="submit" value="Login" />
                    <a href="forgotpass.jsp">Forget Password?</a><br>
                    <a href="registration.jsp" >Create New Account</a>
                </form>
            </div>
        </div>
    </body>
</html>

