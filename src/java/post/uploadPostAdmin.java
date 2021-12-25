package post;

import database.ConnectionPro;
import database.User;
import database.UserDatabase;
import database.post;
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

@MultipartConfig
public class uploadPostAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String text = request.getParameter("textarea");
            String type = request.getParameter("Type");
            Part part = request.getPart("photo");
            String filename = part.getSubmittedFileName();
            
            if(text.equals(""))
            {
                text="none0000";
                String path = getServletContext().getRealPath("/img/posts"+File.separator+filename);
            
                InputStream is = part.getInputStream();

                boolean test = uploadFile(is, path);
                if(test)
                {
                    UserDatabase db = new UserDatabase(ConnectionPro.getConnection());
                    HttpSession session = request.getSession();
                    User usr = (User) session.getAttribute("logUser");
                    post obj = new post(usr.getEmail(),text,path,type);
                    if(db.savePost(obj))
                    {
                        response.sendRedirect("admin.jsp");
                    }
                    else
                    {
                        out.println("<center>Error uploading the Post</center>");
                    }
                }
                else
                {
                    out.println("<center>Error uploading the Post</center>");
                }
            }
            
            else if(part.getSize()==0){
                    String path="none0000";
                    UserDatabase db = new UserDatabase(ConnectionPro.getConnection());
                    HttpSession session = request.getSession();
                    User usr = (User) session.getAttribute("logUser");
                    post obj = new post(usr.getEmail(),text,path,type);
                    if(db.savePost(obj))
                    {
                        response.sendRedirect("admin.jsp");
                    }
                    else
                    {
                        out.println("<center>Error uploading the Post</center>");
                    }
            }
            
            else{
                String path = getServletContext().getRealPath("/img/"+"posts"+File.separator+filename);
            
                InputStream is = part.getInputStream();

                boolean test = uploadFile(is, path);
                if(test)
                {
                    UserDatabase db = new UserDatabase(ConnectionPro.getConnection());
                    HttpSession session = request.getSession();
                    User usr = (User) session.getAttribute("logUser");
                    post obj = new post(usr.getEmail(),text,path,type);
                    if(db.savePost(obj))
                    {
                        response.sendRedirect("admin.jsp");
                    }
                    else
                    {
                        out.println("<center>Error uploading the Post</center>");
                    }
                }
                else
                {
                    out.println("<center>Error uploading the Post</center>");
                }
            }
            
        }
    }
 
    public boolean uploadFile(InputStream is, String path) {
        boolean test = false;
        try{
            byte [] byt = new byte[is.available()];
            is.read(byt);
            FileOutputStream fops = new FileOutputStream(path);
            fops.write(byt);
            fops.flush();
            fops.close();
            
            test = true;
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return test;
    }
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}

