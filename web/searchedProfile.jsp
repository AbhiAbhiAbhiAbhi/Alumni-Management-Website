<%-- 
    Document   : searchedProfile
    Created on : 13 Mar, 2021, 12:54:06 PM
    Author     : NJ
--%>

<%@page import="database.UserDatabase"%>
<%@page import="database.post"%>
<%@page import="database.AboutAlumni"%>
<%@page import="java.util.List"%>
<%@page import="database.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    User user = (User) session.getAttribute("logUser");
    List<User> u = null;
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User usr = (User) session.getAttribute("searchedUser");
    AboutAlumni aa = (AboutAlumni) session.getAttribute("userData");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/alumniProfile.css" rel="stylesheet" type="text/css"/>
        <title><%=usr.getFname()+" "+usr.getLname() %></title>
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
                <img src="<%= usr.getProfile().substring(64) %>">
            </div>
            
            <div class="prodetail">
                <div class="details">
                    <span><%= usr.getSid() %></span>
                </div>
                <div class="details">
                    <span>Batch : <%= usr.getBatch() %></span>
                </div>
                <div class="details">
                    <span>Branch : <%= usr.getBranch() %></span>
                </div>
                <div class="details">
                    <span style="font-weight: bold;"><%= usr.getFname()+" "+usr.getMname()+" "+usr.getLname()  %></span>
                </div>
                <div class="details">
                    <span><%= usr.getEmail() %></span>
                </div>
                <div class="details">
                    <span>DOB: <%= usr.getDOB() %></span>
                </div>
                <div class="details" id="biospan">
                    <%if(!aa.getBio().equals("Add Bio")) 
                    {%>
                        <span><%= aa.getBio() %></span>
                    <%}%>
                </div>
                <div class="details">
                    <%if(!aa.getCuremp().equals("Add Employment")) 
                    {%>
                        <span> <%= aa.getCuremp()%></span>
                    <%}%>
                </div>
                <div class="details">
                    <%if(!aa.getPastemp().equals("Add Past Employment")) 
                    {%>
                        <span><%= aa.getPastemp()%></span>
                    <%}%>   
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
                        if(i.getEmail().equals(usr.getEmail())){
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
