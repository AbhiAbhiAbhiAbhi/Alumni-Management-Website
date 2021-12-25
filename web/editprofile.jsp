<%@page import="database.AboutAlumni"%>
<%@page import="database.UserDatabase"%>
<%@page import="database.ConnectionPro"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="database.User"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    User user = (User) session.getAttribute("logUser");
    if (user == null) {

        response.sendRedirect("login.jsp");
        return;
    }

    UserDatabase db = new UserDatabase(ConnectionPro.getConnection());
    AboutAlumni aa = db.getAlumniData(user);

%>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/editProfile.css" rel="stylesheet" type="text/css"/>

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
                    <a href="alumni.jsp"><img src="img/home.png"></a>
                </div>
            </div>

            <div class="right">
                <div class="message">
                    <a href="almnChat.jsp"><img src="img/message.png"></a>
                </div>
                <div class="notification">
                    <a href="#"><img src="img/notification.png"></a>
                </div>
                <div class="profile">
                    <a href="alumniProfile.jsp"><img src="img/profile.png"></a>
                </div>
                <div class="logout">
                    <a href="LogoutServlet"><img src="img/logout.png"></a>
                </div>
            </div>
        </header>

        <div class="form-popup" id="edit-profile-form">
            <div>
                <h1 style="margin-top: 15px;text-align: center;text-shadow: 2px 2px ghostwhite;">Edit Profile</h1>
            </div>

            <form class="form-container" action="editAlumni" method="POST" enctype="multipart/form-data">
                <div id="info-div">
                    <div class="propic" id="edit-propic">
                    <table style="width:100%">
                        <tr><td><img src="<%= user.getProfile().substring(64) %>" id="output"></td>
                            <td><input type="file" name="propic" class="custom-file-input" accept="image/*" onchange="loadFile(event)"></td>
                        </tr>
                    </table>
                    </div>
                    <table style="width:60%; text-align: justify">
                        <tr>
                            <td>Student ID :</td>   
                            <td><%= user.getSid()%></td>
                        </tr>
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
                            <td>Batch :</td>   
                            <td><%= user.getBatch()%></td>
                        </tr>
                        <tr>
                            <td>Branch :</td>   
                            <td><%= user.getBranch()%></td>
                        </tr>
                        <tr>
                            <td>Bio :</td>
                            <td><textarea rows="4" cols="40" name="bio"  ><%= aa.getBio()%></textarea></td>
                        </tr>
                        <tr>
                            <td>Current Employment :</td>
                            <td><input type="text" name="curremp" value="<%= aa.getCuremp()%>"></td>
                        </tr>
                        <tr>
                            <td>Past Employments :</td>
                            <td><textarea rows="4" cols="40" name="pastemp" ><%= aa.getPastemp()%></textarea></td>
                        </tr>
                        <tr>
                            <td>City :</td>
                            <td><input type="text" name="city" value="<%= aa.getCity()%>"></td>
                        </tr>
                        <tr>
                            <td>State :</td>
                            <td><input type="text" name="state" value="<%= aa.getState()%>"></td>
                        </tr>
                        <tr>
                            <td>Country :</td>
                            <td><input type="text" name="country" value="<%= aa.getCountry()%>"></td>
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
                <a href="alumniProfile.jsp"><button id="cancelbtn" type="button">Cancel</button></a>

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

    </body>
</html>
