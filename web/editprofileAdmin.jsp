<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="database.User"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    User user = (User) session.getAttribute("logUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/editprofileAdmin.css" rel="stylesheet" type="text/css"/>

        <script type='text/javascript'>
        var passcheck = function () {
            if (document.getElementById('1').value.length < 7)
            {
                document.getElementById('1').setCustomValidity('Length of password should be atleast of 8');
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
        
        <title>Edit Profile</title>
    </head>
    <body>
        <header class="header">
            <div class="left">
                <div class="logo">
                    <img src="img/logo.jpeg">
                </div>
            </div>

            <div class="center">
                <div class="home">
                    <a href="admin.jsp"><img src="img/home.png"></a>
                </div>
            </div>

            <div class="right">
                <div class="message">
                    <a href="admChat.jsp"><img src="img/message.png"></a>
                </div>
                <div class="notification">
                    <a href="#"><img src="img/notification.png"></a>
                </div>
                <div class="profile">
                    <a href="adminProfile.jsp"><img src="img/profile.png"></a>
                </div>
                <div class="manage">
                    <a href="#"><img src="img/manage.png"></a>
                </div>
                <div class="logout">
                    <a href="LogoutServlet"><img src="img/logout.png"></a>
                </div>
            </div>
        </header>
        <div>
            <h1 style="margin-top: 15px;text-align: center;text-shadow: 2px 2px ghostwhite;">Edit Profile</h1>
        </div>

        <div class="form-popup" id="edit-profile-form">
                <form class="form-container" action="editAdmin" method="POST" enctype="multipart/form-data">
                    <div id="info-div">
                        <div class="propic" id="edit-propic">
                            <table style="width:100%">
                                <tr><td><img src="<%= user.getProfile().substring(64)%>" id="output"></td>
                                    <td><input type="file" name="propic" class="custom-file-input" accept="image/*" onchange="loadFile(event)"></td>
                                </tr>
                            </table>
                        </div>
                        <br>
                        <table style="width:60%">
                            <tr>
                                <td>First Name :</td>   
                                <td><%= user.getFname()%></td>
                            </tr>
                            <tr>
                                <td>Middle Name :</td>   
                                <td><input type="text" name="mname" value="<%= user.getMname()%>"></td>
                            </tr>
                            <tr>
                                <td>Last Name :</td>
                                <td><input type="text" name="lname" value="<%= user.getLname()%>"></td>
                            </tr>
                            <tr>
                                <td>New Password :</td>
                                <td><input type="password" name="npass" id="1" onkeyup="passcheck();" value="<%= user.getPassword()%>"></td>
                            </tr>
                            <tr>
                                <td>Confirm New Password :</td>
                                <td><input type="password" name="cnpass" id="2" onkeyup="passcheck();" value="<%= user.getPassword()%>"></td>
                            </tr>
                        </table>
                    </div>

                    <button id="updatebtn" type="submit">Update profile</button>
                    <a href="adminProfile.jsp"><button id="cancelbtn" type="button">Cancel</button></a>

                </form>
            </div>

            <script>
                var loadFile = function (event) {
                    var output = document.getElementById('output');
                    output.src = URL.createObjectURL(event.target.files[0]);
                    output.onload = function () {
                        URL.revokeObjectURL(output.src) // free memory
                    }
                }
            </script>   
    </body>
</html>
