<%@page import="database.ConnectionPro"%>
<%@page import="java.util.List"%>
<%@page import="database.post"%>
<%@page import="database.UserDatabase"%>
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/homeAlumni.css" rel="stylesheet" type="text/css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <script>
            var check = function () {
                document.getElementById("upload").disabled = false;
            };

            function doReport(id, email) {
                
                const d = {
                pid: id,
                email: email
                };

                $.ajax({
                    url: "reportPostServlet",
                    data: d,
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(data)
                    }
                })
                
                document.getElementById(id).value = 'Reported';
                document.getElementById(id).disabled = true;
            }
        </script>

        <title>Welcome</title>
    </head>
    <body class="body">
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
                <div class="profile">
                    <a href="alumniProfile.jsp"><img src="img/profile.png"></a>
                </div>
                <div class="logout">
                    <a href="LogoutServlet"><img src="img/logout.png"></a>
                </div>
            </div>
        </header>

        <div class="post">
            <form class="newpost" action="uploadPostAlumni" method="post" enctype="multipart/form-data">
                <textarea name="textarea" onkeyup="check()"  placeholder="Post something...."></textarea>
                <div class="uploadfun">
                    <lable>Photo: </lable><input type="file" onchange="check()" id="photo" name="photo" value="Photo" accept="image/*">
                    <select name='Type' id='select'>
                        <option value="NORMAL">NORMAL</option>
                        <option value="SEMINAR">SEMINAR</option>
                        <option value="JOB">JOB</option>
                    </select>
                    <input type="submit" id="upload" value="Upload" disabled="true">
                </div>
            </form>

            <div class="mainloadpost">
                <%
                    UserDatabase db = new UserDatabase(ConnectionPro.getConnection());
                    List<post> list = db.getPost();
                    for (post i : list) {
                        if(!db.checkReportedPost(i.getPostID() ))
                        {
                        User usr = db.getUserName(i.getEmail());
                %>
                <%if (i.getPhoto().equals("none0000")) {%>
                <div class="loadpost" style="height: 200px;">
                    <% } else {%>
                    <div class="loadpost" style="height: 620px;">
                        <% }%>
                        <div class="udetail">
                            <div class="upp">
                                <img src="<%=usr.getProfile().substring(64)%>">
                            </div>
                            <div class="uname">
                                <%= usr.getFname() + " " + usr.getLname()%>
                            </div>
                            <div class="ptime">
                                <%= i.getDate()%>
                            </div>
                            
                            <%if(! i.getType().equals("NORMAL")){%>
                                <div class="type">
                                   <%= i.getType()%>
                                </div>
                            <%}%>
                            
                            <div class="report">
                                <%
                                    if (!i.getEmail().equals(user.getEmail())) {
                                        if(db.userReportedPost(i.getPostID(), user.getEmail() )){%>
                                            <input type="button" id="<%=i.getPostID()%>" value="Reported" disabled='true' />
                                        <% } else { %>
                                        <input type="button" id="<%=i.getPostID()%>" onclick="doReport(this.id, '<%=user.getEmail() %>' )" value="Report" />
                                        <% }
                                    }
                                %>
                            </div>
                        </div>
                        <div class="postdetail">
                            <%if (!i.getText().equals("none0000")) {%>
                            <div class="textpost" style="padding-bottom: 16.4px;"><%= i.getText()%></div>
                            <% } %>

                            <%if (!i.getPhoto().equals("none0000")) {%>
                            <div class="photopost" style="padding-bottom: 10px;">
                                <img src="<%= i.getPhoto()%>"  style="padding-bottom: 16.4px;"/>
                            </div>
                            <% } %>

                        </div>
                    </div>
                    <% }}
                    for (post i : list) {
                        if(db.checkReportedPost(i.getPostID() ))
                        {
                        User usr = db.getUserName(i.getEmail());
                %>
                <%if (i.getPhoto().equals("none0000")) {%>
                <div class="loadpost" style="height: 200px;">
                    <% } else {%>
                    <div class="loadpost" style="height: 620px;">
                        <% }%>
                        <div class="udetail">
                            <div class="upp">
                                <img src="<%=usr.getProfile().substring(64)%>">
                            </div>
                            <div class="uname">
                                <%= usr.getFname() + " " + usr.getLname()%>
                            </div>
                            <div class="ptime">
                                <%= i.getDate()%>
                            </div>
                            <div class="report">
                                <%
                                    if (!i.getEmail().equals(user.getEmail())) {
                                        if(db.userReportedPost(i.getPostID(), user.getEmail() )){%>
                                            <input type="button" id="<%=i.getPostID()%>" value="Reported" disabled='true' />
                                        <% } else { %>
                                        <input type="button" id="<%=i.getPostID()%>" onclick="doReport(this.id, '<%=user.getEmail() %>' )" value="Report" />
                                        <% }
                                    }
                                %>
                            </div>
                        </div>
                        <div class="postdetail">
                            <%if (!i.getText().equals("none0000")) {%>
                            <div class="textpost"><%= i.getText()%></div>
                            <% } %>

                            <%if (!i.getPhoto().equals("none0000")) {%>
                            <div class="photopost">
                                <img src="<%= i.getPhoto()%>" />
                            </div>
                            <% } %>

                        </div>
                    </div>
                    <% }}%>
                </div>
            </div>
            </div>
        </div>
    </body>
</html>
