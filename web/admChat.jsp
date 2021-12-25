<%@page import="database.message"%>
<%@page import="database.UserDatabase"%>
<%@page import="database.ConnectionPro"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="database.User"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    User user = (User) session.getAttribute("logUser");
    List<User> u = null;
    
    UserDatabase db = new UserDatabase(ConnectionPro.getConnection());
    User searchedUser = (User) session.getAttribute("searchedUser");
    User otherUser = (User) session.getAttribute("otherUser");
    
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Message</title>
        <link href="css/adminChat.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="script/chat.js"></script>

    </head>
    <% if(searchedUser != null){%>
        <body onload="load('<%=searchedUser.getEditedEmail() %>')">
    <%}else{
        if(otherUser != null){%>
            <body onload="load('<%=otherUser.getEditedEmail() %>')">
        <%
            session.removeAttribute("otherUser");
        }else{%>
            <body >
        <%}
    }%>
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

        <div class="chatarea" id="chatarea">

            <div class="leftarea">
                <div class="search">
                    <input type="text" id="search" placeholder="Search a friend" required />
                    <input type="text" id="batch" placeholder="Batch" onkeyup="validate(this.id)"/>
                    <span id="limit" style="display: none;position: absolute;top:80%;left:14%;font-size: 12px;">Length limit = 4</span>

                    <div class="dropdown" id="branch">
                        <select name="branch" id="select">
                            <option class="option" value="none">Branch</option>
                            <option class="option" value="IT">IT</option>
                            <option class="option" value="CE">CE</option>
                            <option class="option" value="EC">EC</option>
                            <option class="option" value="EC">IC</option>
                            <option class="option" value="EC">CH</option>
                            <option class="option" value="EC">CL</option>
                            <option class="option" value="EC">MH</option>
                        </select>
                    </div>

                    <button class="srch" id="searchbtn" onclick="searchUser('search', 'batch', 'select')" value="Search">Search</button>
                </div>

                <div class="searchResult" id="result">
                
                </div>
                
                <div class="recent">
                    <% 
                        if(searchedUser != null)
                        {%>
                            <div class="container" id='<%=searchedUser.getEditedEmail() %>' onclick="load('<%=searchedUser.getEditedEmail() %>')">
                                <div class="profilepic">
                                    <img src="<%=searchedUser.getProfile().substring(64)%>">
                                </div>
                                <div class="Uname">
                                    <%= searchedUser.getFname() + " " + searchedUser.getLname()%>
                                </div>
                            </div>
                        <%}
                                                
                        for(User i: db.getRecentUser(db.getRecent(user.getEmail())))
                        {%>
                            <div class="container" id='<%=i.getEditedEmail() %>' onclick="load('<%=i.getEditedEmail() %>')">
                                <div class="profilepic">
                                    <img src="<%=i.getProfile().substring(64)%>">
                                </div>
                                <div class="Uname">
                                    <%= i.getFname() + " " + i.getLname()%>
                                </div>
                            </div>
                        <%}%>
                </div>
            </div>

             <%
                 if(searchedUser != null)
                 {%>
                    <div class="rightarea" id="<%=searchedUser.getEditedEmail()+"1" %>" onclick="">
                        <div class="top">
                            <div class="photo">
                               <img src="<%=searchedUser.getProfile().substring(64) %>"></div>
                            <div class="name"><%= searchedUser.getFname() + " " + searchedUser.getLname()%></div>
                        </div>
                        <div class="chat" id="<%=searchedUser.getEditedEmail()+"2" %>">
                           <%
                            List<message> m = db.getMessage(user.getEmail(), searchedUser.getEmail());
                            for(message j: m)
                            {
                                if(j.getSendEmail().equals(user.getEmail())){
                           %>
                                    <div class="messag rght">
                                       <div class="msgtxt"><%=j.getChat() %>
                                       </div>
                                       <div class="timelable"><%=j.getDate().toString().substring(0,16) %>
                                       </div>
                                    </div>
                                <%} else {%>
                                    <div class="messag lft">
                                       <div class="msgtxt"><%=j.getChat() %>
                                       </div>
                                       <div class="timelable"><%=j.getDate().toString().substring(0,16) %>
                                       </div>
                                   </div>
                                <%}
                           }%>
                        </div>

                        <div class="txt">
                            <input type="text" id="<%=searchedUser.getEmail()+"1" %>" onkeypress="clickSend(this.id,'<%=searchedUser.getEmail()+"4" %>')" placeholder="Type a message..." />
                            <input type="button" id="<%=searchedUser.getEmail()+"4" %>" onclick="sendmsg('<%=searchedUser.getEmail()+"1" %>','<%=searchedUser.getEmail() %>')" value="Send" />
                        </div>
                    </div>
                 <%
                    session.removeAttribute("searchedUser");
                 }
                 for(User i: db.getRecentUser(db.getRecent(user.getEmail())))
                {%>   
                    <div class="rightarea" id="<%=i.getEditedEmail()+"1" %>" onclick="">
                        <div class="top">
                            <div class="photo">
                               <img src="<%=i.getProfile().substring(64) %>"></div>
                            <div class="name"><%= i.getFname() + " " + i.getLname()%></div>
                        </div>
                        <div class="chat" id="<%=i.getEditedEmail()+"2" %>">
                        <%
                            List<message> m = db.getMessage(user.getEmail(), i.getEmail());
                            for(message j: m)
                            {
                                if(j.getSendEmail().equals(user.getEmail())){
                           %>
                                    <div class="messag rght">
                                       <div class="msgtxt"><%=j.getChat() %>
                                       </div>
                                       <div class="timelable"><%=j.getDate().toString().substring(0,16) %>
                                       </div>
                                    </div>
                                <%} else {%>
                                    <div class="messag lft">
                                       <div class="msgtxt"><%=j.getChat() %>
                                       </div>
                                       <div class="timelable"><%=j.getDate().toString().substring(0,16) %>
                                       </div>
                                   </div>
                                <%}
                            }%>
                        </div>

                        <div class="txt">
                            <input type="text" id="<%=i.getEmail()+"1" %>" onkeypress="clickSend(this.id,'<%=i.getEmail()+"4" %>')" placeholder="Type a message..." />
                            <input type="button" id="<%=i.getEmail()+"4" %>" onclick="sendmsg('<%=i.getEmail()+"1" %>','<%=i.getEmail() %>')" value="Send" />
                        </div>
                    </div>
                   <%}%>
        </div>
    </div>
</body>
</html>