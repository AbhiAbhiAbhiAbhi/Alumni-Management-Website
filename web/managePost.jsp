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
        <link href="css/managePost.css" rel="stylesheet" type="text/css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

        <script>
            function deletePost(id){
                console.log(id);
                
                document.getElementById(id).value = "Deleted";
                document.getElementById(id).disabled = true;
                document.getElementById(id+"1").disabled = true;
                const d = {
                pid: id
                };

                $.ajax({
                    url: "deleteReportedPostServlet",
                    data: d,
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(data)
                    }
                })
            };
            
            function ignorePost(id,PostId){
                console.log(id);
                
                document.getElementById(id).value = "Ignored";
                document.getElementById(id).disabled = true;
                document.getElementById(PostId).disabled = true;
                const d = {
                pid: PostId
                };

                $.ajax({
                    url: "ignoreReportedPostServlet",
                    data: d,
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(data)
                    }
                })
            }
        </script>

        <title>Manage Posts</title>
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

        <div class="post">
            
            <div class="mainloadpost">
                <%
                    UserDatabase db = new UserDatabase(ConnectionPro.getConnection());
                    List<post> list = db.getReportedPost();
                    for (post i : list) {
                        User usr = db.getUserName(i.getEmail());
                        if (i.getPhoto().equals("none0000")) {%>
                <div class="loadpost" style="height: 200px;">
                    <% } else {%>
                    <div class="loadpost" style="height: 620px;">
                        <% }%>
                            <div class="udetail">
                                <div class="upp">
                                    <img src="<%=usr.getProfile().substring(64) %>">
                                </div>
                                <div class="uname">
                                    <%= usr.getFname() + " " + usr.getLname()%>
                                </div>
                                <div class="ptime">
                                    <%= i.getDate() %>
                                </div>
                                <div class="dlt">
                                    Report Count: <%=i.getNoOfReport() %>
                                    <input type="Button" id="<%=i.getPostID() %>" onclick="deletePost(this.id)" value="Delete">
                                </div>
                                <div class="ignr">
                                    <input type="Button" id="<%=i.getPostID()+"1" %>" onclick="ignorePost(this.id,'<%=i.getPostID() %>')" value="Ignore">
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
                    <% }
                       if(list.isEmpty()){
                    %>
                    <center>No more Posts!!!</center>
                    <%}%>
            </div>
        </div>
    </body>
</html>
