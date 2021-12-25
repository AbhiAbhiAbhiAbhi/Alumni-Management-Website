<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="css/welcome.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
          <script>
            function scrollWin() {
              window.scrollBy({
                    top: 100000,
                    behavior: 'smooth'});
            }
</script>
        <title>Alumni Association</title>
    </head>
    <body>
        <header class="header">
            <div class="left">
                <img src="img/logo.jpeg">
                <p>Alumni Association</p>
            </div>
           
            <div class="right">
                <ul class="navbar">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a onclick='scrollWin()'>About Us</a></li>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="registration.jsp">Register</a></li>
                </ul>
            </div>
        </header>
        <div>
            <img class="coverpic" src="img/welcome-2.jpg">
        </div>
        
        
        <footer>
            <div class='leftf'>
            <h2>Usefull Links</h2><br />
            <a href='http://ddu.ac.in/'>DDU Website DDU Official Website</a><br /><br />
            <a href='http://dduconnect.in/'>DDU Connect DDUs Newspaper</a>
            </div>
            <div class='rightf'>
                University Address<br /><br /><br /><i class="fa fa-home"></i>College Road, Nadiad, Gujarat 387001<br /><br />
                02682520502<br /><br />02682520501<br /><br />registrar@ddu.ac.in
            </div>
        </footer>
    </body>
</html>