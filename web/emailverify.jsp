<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <title>Email Verification</title>
    </head>
    <body>
        <div class="container">
            <div class="fbox">
                <h3>We have sent you Verification code!!</h3>
                <form action="VerifyCode" method="post">
                    <input type="text" placeholder="Code" name="authcode" required />
                    <input type="submit" value="Verify" />
                </form>
            </div>
        </div>
    </body>
</html>
