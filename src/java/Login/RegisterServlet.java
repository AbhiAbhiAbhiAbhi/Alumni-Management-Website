package Login;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import database.ConnectionPro;
import database.UserDatabase;
import database.User;
import database.sendEmail;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author NJ
 */
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head><link href=\"css/style.css\" rel=\"stylesheet\" type=\"text/css\"/>");
            out.println("<title>Login</title>");
            out.println("</head>");
            /* TODO output your page here. You may use following sample code. */
            //fetch from registration page
            String fname = request.getParameter("FirstName");
            String mname = request.getParameter("MiddleName");
            String lname = request.getParameter("LastName");
            String sid = request.getParameter("StudentID");
            String email = request.getParameter("EmailAdd");
            String password = request.getParameter("Password");
            String date = request.getParameter("DOB");
            String gender = request.getParameter("Gender");

            //make user object
            UserDatabase db = new UserDatabase(ConnectionPro.getConnection());

            User user = null;
            String status = db.checkStatus(sid);
            if (db.checkUser(sid) == null) {
                out.println("<body><div class=\"container\"><div class=\"nubox\">");
                out.println("<center>Please check your Student ID!!!<br><a href=\"registration.jsp\">Click Here</a>");
            } else if (status.equals("Y")) {
                out.println("<body><div class=\"container\"><div class=\"nafbox\">");
                out.println("<center>This Student ID is already in use!!!<br><a href=\"login.jsp\">Login Here</a><br><br><a href=\"registration.jsp\">Change Student ID</a><br><br>Forgot Passwor??<br><a href=\"forgotpass.jsp\">Click Here</a>");
            } else {
                user = db.logUserf(email);
                
                String batch = db.getUserBatch(sid);
                String branch = db.getUserBranch(sid);
                if (user == null) {
                    //create instance object of the SendEmail Class                
                    sendEmail sm = new sendEmail();
                    //get the 6-digit code
                    String code = sm.getRandom();

                    //craete new user using all information
                    user = new User(sid, fname, mname, lname, batch, branch, email, password, date, gender);
                    user.setCode(code);

                    //call the send email method
                    boolean test = sm.sendEmail(user);

                    //check if the email send successfully
                    if (test) {
                        HttpSession session = request.getSession();
                        session.setAttribute("authcode", user);
                        response.sendRedirect("emailverify.jsp");
                    } else {
                        out.println("Failed to send verification email");
                    }

                } else {
                    out.println("<body><div class=\"container\"><div class=\"nafbox\">");
                    out.println("<center>This Email Address is already in use!!!<br><a href=\"login.jsp\">Login Here</a><br><br><a href=\"registration.jsp\">Use another Email Address</a><br><br>Forgot Password??<br><a href=\"forgotpass.jsp\">Click Here</a>");
                }
            }
            out.println("</div></div></body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
