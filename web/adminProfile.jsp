<%@page import="java.util.List"%>
<%@page import="database.post"%>
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/adminProfile.css" rel="stylesheet" type="text/css"/>
        <title>Profile</title>
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
                <div class="profile">
                    <a href="adminProfile.jsp"><img src="img/profile.png"></a>
                </div>
                <div class="manage">
                    <a href="managePost.jsp"><img src="img/manage.png"></a>
                </div>
                <div class="logout">
                    <a href="LogoutServlet"><img src="img/logout.png"></a>
                </div>
            </div>
        </header>
        <div class="btm">
            <div class="leftp">
                <div class="propic">
                    <img src="<%= user.getProfile().substring(64)%>">
                </div>
                <div class="buttons">
                    <a href="editprofileAdmin.jsp"><input type="button" id="editbtn" value="Edit Profile" ></a>
                </div>

                <div class="prodetail">

                    <div class="details">
                        <span style="font-weight: bold;"><%= user.getFname() + " " + user.getMname() + " " + user.getLname()%></span>
                    </div>
                    <div class="details">
                        <span><%= user.getEmail()%></span>
                    </div>
                    <div class="details">
                        <span>DOB: <%= user.getDOB()%></span>
                    </div>
                </div>
            </div>

            <div class="rightp">
                <div class="mainloadpost">
                    <%
                        List<post> list = UserDatabase.getPost();
                        for (post i : list) {
                            User usr = db.getUserName(i.getEmail());
                            if (i.getEmail().equals(user.getEmail())) {
                    %>
                    <%if (i.getPhoto().equals("none0000")) {%>
                    <div class="loadpost" style="height: 200px;">
                        <% } else {%>
                        <div class="loadpost" style="height: 620px;">
                            <% }%>
                            <form action="deleteAdminPost" method="post">
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
                                    <div class="dlt">
                                        <input type="text" name="postId" value="<%=i.getPostID()%>" style="display:none"/>
                                        <input type="submit" value="Delete">
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
                            </form>
                        </div>
                        <% }
                        }%>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
