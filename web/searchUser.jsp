<%-- 
    Document   : searchUserServlet
    Created on : 13 Mar, 2021, 11:48:09 AM
    Author     : NJ
--%>

<%@page import="java.util.List"%>
<%@page import="database.User"%>
<%@page import="database.ConnectionPro"%>
<%@page import="database.UserDatabase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
            String name = request.getParameter("name");
            String batch = request.getParameter("batch");
            String branch = request.getParameter("branch");
            
            UserDatabase db = new UserDatabase(ConnectionPro.getConnection());
            
            List <User> u = db.getSearchedUser(batch, branch, name.toUpperCase());
            
            for(User i: u)
            {%>
                <div class="resultContainer">
                    <div class="ppic">
                        <img src="<%=i.getProfile().substring(64)%>">
                    </div>
                    <div class="name">
                        <%= i.getFname() + " " + i.getLname()%>
                    </div>
                    <div class="data">
                        <%= i.getBranch() + " " + i.getBatch() %>
                    </div>
                    <div class="viewButton">
                        <form action="openSearchedServlet" method="POST">
                            <button type="submit" name="emailAddress" value="<%=i.getEmail() %>" onclick="hideResult()">View</button>
                        </form>
                    </div>
                    <div class="chatButton">
                        <form action="searchUserDivServlet" method="post">
                            <input type="text" name="email" value="<%=i.getEmail() %>" hidden />
                            <button type="submit" onclick="hideResult()">Chat</button>
                        </form>
                    </div>
                </div>
            <%}%>
                
    </body>
</html>
