package Login;

import database.AboutAlumni;
import database.ConnectionPro;
import database.UserDatabase;
import database.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class VerifyCode extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("authcode");

            String code = request.getParameter("authcode");

            if (code.equals(user.getCode())) {
                UserDatabase db = new UserDatabase(ConnectionPro.getConnection());
                db.saveUser(user);
                AboutAlumni aa = new AboutAlumni();
                aa.setId(user.getSid());
                db.saveAa(aa);
                response.sendRedirect("login.jsp");
                
            } else {
                out.println("Incorrect verification code");
                out.print("<a href=\"registration.jsp\" >Try Again</a>");
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
