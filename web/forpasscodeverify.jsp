<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot password code verification</title>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <script type='text/javascript'>
            var passcheck = function () {
                if (document.getElementById('1').value.length < 7)
                {
                    document.getElementById('1').setCustomValidity('Length of password should be atleast of 8');
                } else
                {
                    document.getElementById('1').setCustomValidity('');
                }
                if (document.getElementById('1').value.length > 20)
                {
                    document.getElementById('1').setCustomValidity('Length of password should be atmost of 20');
                } else
                {
                    document.getElementById('1').setCustomValidity('');
                }
                if (document.getElementById('1').value != document.getElementById('2').value)
                {
                    document.getElementById('2').setCustomValidity("Password Don't Match");
                } else
                {
                    document.getElementById('2').setCustomValidity('');
                }
            }
        </script> 
    </head>
    <body>

        <div class="container">
            <div class="fpcvbox">
                <form action="forcodecheck" method="post">
                    <input type="text" placeholder="Code" name="authcode" required />
                    <input type="password" placeholder="New Password" id="1" name="Password" onkeyup="passcheck();" required />
                    <input type="password" placeholder="Confirm Password" id="2" name="Confirm Password" onkeyup="passcheck();" required />

                    <input type="submit" value="Verify" />
                </form>
            </div>
        </div>
    </body>
</html>
