/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author DELL
 */
@MultipartConfig
public class editAlumni extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            Part part = request.getPart("propic");
            String filename = part.getSubmittedFileName();

            String mname = request.getParameter("mname");
            String lname = request.getParameter("lname");
            String curremp = request.getParameter("curremp");
            String bio = request.getParameter("bio");
            String pastemp = request.getParameter("pastemp");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String country = request.getParameter("country");
            String password = request.getParameter("npass");

            mname = mname.toUpperCase();
            lname = lname.toUpperCase();
            
            UserDatabase db = new UserDatabase(ConnectionPro.getConnection());
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("logUser");
            
            User usr = new User(user.getSid(), user.getFname(), mname, lname, user.getBatch(), user.getBranch(), user.getEmail(), password, user.getDOB(), user.getGender());
            usr.setProfile(user.getProfile());

            if (part.getSize() != 0) {
                String path = getServletContext().getRealPath("/img/profile" + File.separator + filename);

                InputStream is = part.getInputStream();

                boolean test = uploadFile(is, path);
                if (test) {
                    usr.setProfile(path);
                    if (db.updateUserPhoto(usr)) {
                        session.setAttribute("logUser", usr);
                    } else {
                        out.println("<center>Error uploading Photo</center>");
                    }
                } else {
                    out.println("<center>Error uploading the Photo</center>");
                }
            }

            AboutAlumni aa = new AboutAlumni(user.getSid(), bio, curremp, pastemp, city, state, country);
            
            db.updateUserData(usr);
            db.updateAlumniData(aa);

            session.setAttribute("logUser", usr);
            response.sendRedirect("alumniProfile.jsp");

        }
    }

    public boolean uploadFile(InputStream is, String path) {
        boolean test = false;
        try {
            byte[] byt = new byte[is.available()];
            is.read(byt);
            FileOutputStream fops = new FileOutputStream(path);
            fops.write(byt);
            fops.flush();
            fops.close();

            test = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return test;
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
