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
<html>
    <head>
        <title>Profile</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/alumniProfile.css" rel="stylesheet" type="text/css"/>
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
                <div class="profile">
                    <a href="alumniProfile.jsp"><img src="img/profile.png"></a>
                </div>
                <div class="logout">
                    <a href="LogoutServlet"><img src="img/logout.png"></a>
                </div>
            </div>
        </header>
        <div class="btm">
        <div class="leftp">
            <div class="propic">
                <img src="<%= user.getProfile().substring(64) %>">
            </div>
            <div class="buttons">
                <a href="editprofile.jsp"><input type="button" id="editbtn" value="Edit Profile" ></a>
            </div>
            
            <div class="prodetail">
                <div class="details">
                    <span><%= user.getSid() %></span>
                </div>
                <div class="details">
                    <span>Batch : <%= user.getBatch() %></span>
                </div>
                <div class="details">
                    <span>Branch : <%= user.getBranch() %></span>
                </div>
                <div class="details">
                    <span style="font-weight: bold;"><%= user.getFname()+" "+user.getMname()+" "+user.getLname()  %></span>
                </div>
                <div class="details">
                    <span><%= user.getEmail() %></span>
                </div>
                <div class="details">
                    <span>DOB: <%= user.getDOB() %></span>
                </div>
                <div class="details" id="biospan">
                    <span>Bio : <%= aa.getBio() %></span>
                </div>
                <div class="details">
                    <span><%= aa.getCuremp() %></span>
                </div>
                <div class="details">
                    <span><%= aa.getPastemp() %></span>
                </div>
                <div class="details">
                    <span><%= aa.getCity()+"  "+aa.getState()+"  "+aa.getCountry() %></span>
                </div>
            </div>
        </div>
        
        <div class="rightp">
            <div class="mainloadpost">
                <%
                    List<post> list = UserDatabase.getPost();
                    for (post i : list) {
                        User usr = db.getUserName(i.getEmail());
                        if(i.getEmail().equals(user.getEmail())){
                %>
                <%if (i.getPhoto().equals("none0000")) {%>
                <div class="loadpost" style="height: 200px;">
                    <% } else {%>
                    <div class="loadpost" style="height: 620px;">
                        <% }%>
                        <form action="deleteUserPost" method="post">
                        <div class="udetail">
                            <div class="upp">
                                <img src="<%=usr.getProfile().substring(64) %>">
                            </div>
                            <div class="uname">
                                <%= usr.getFname() + " " + usr.getLname()%>
                            </div>
                            <div class="ptime">
                                <%= i.getDate()%>
                            </div>
                            <div class="dlt">
                                <input type="text" name="postId" value="<%=i.getPostID() %>" style="display:none"/>
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
                    <% }}%>
                </div>
            </div>
        </div>
        </div>
    </body>
</html>
