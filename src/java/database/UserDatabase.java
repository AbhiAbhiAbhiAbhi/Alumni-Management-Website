/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author NJ
 */
public class UserDatabase {

    Connection con;

    public UserDatabase(Connection con) {
        this.con = con;
    }

    //for register user 
    public void saveUser(User user) {
        try {
            //Insert register data to database
            String query = "insert into user(ID,FirstName,MiddleName,LastName,Batch,Branch,EmailAdd,Password,DOB,Gender) values(upper(?),upper(?),upper(?),upper(?),upper(?),upper(?),upper(?),?,?,upper(?))";

            PreparedStatement pt = this.con.prepareStatement(query);
            pt.setString(1, user.getSid());
            pt.setString(2, user.getFname());
            pt.setString(3, user.getMname());
            pt.setString(4, user.getLname());
            pt.setString(5, user.getBatch());
            pt.setString(6, user.getBranch());
            pt.setString(7, user.getEmail());
            pt.setString(8, user.getPassword());
            pt.setString(9, user.getDOB());
            pt.setString(10, user.getGender());
            user.setStatus("Y");

            pt.executeUpdate();
            
            String query2 = "update student set Status = ? where Student_ID = ?";
            PreparedStatement pst = this.con.prepareStatement(query2);
            pst.setString(2, user.getSid());
            pst.setString(1, user.getStatus());
            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //user login
    public User logUser(String email, String pass) {
        User usr = null;
        try {
            String query = "select * from user where EmailAdd=upper(?) and Password=?";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, pass);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                usr = new User();
                usr.setSid(rs.getString("ID"));
                usr.setFname(rs.getString("FirstName"));
                usr.setMname(rs.getString("MiddleName"));
                usr.setLname(rs.getString("LastName"));
                usr.setBatch(rs.getString("Batch"));
                usr.setBranch(rs.getString("Branch"));
                usr.setEmail(rs.getString("EmailAdd"));
                usr.setPassword(rs.getString("Password"));
                usr.setDOB(rs.getString("DOB"));
                usr.setGender(rs.getString("Gender"));
                usr.setProfile(rs.getString("ProfilePhoto"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return usr;
    }
    //to reset password
    public void resetPassword(User user) {
        try {
            //Insert register data to database
            String query = "update user set Password=? where upper(EmailAdd)=upper(?)";

            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, user.getPassword());
            pst.setString(2, user.getEmail());

            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //check by Student id if user exists in student table
    public User checkUser(String sid) {
        User user = null;
        try {
            String query = "select * from student where Student_ID = upper(?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, sid);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                String[] name = rs.getString("Name").split(" ");
                
                user.setFname(name[0]);
                user.setMname(name[1]);
                user.setLname(name[2]);
                user.setDOB(rs.getString("DOB"));
                user.setGender(rs.getString("Gender"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return user;
    }
    //check if student is already registered or not
    public String checkStatus(String sid)
    {
        String status = "N";
        try {
            String query = "select * from student where Student_ID= upper(?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, sid);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                status = rs.getString("Status");
            }
            } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    //get user batch and branch
    public String getUserBatch(String sid){
        String batch = null;
        try {
            String query = "select Batch from student where Student_ID=upper(?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, sid);
            
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                batch = rs.getString("Batch");
            }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return batch;
    }
    
    public String getUserBranch(String sid){
        String branch = null;
        try {
            String query = "select Branch from student where Student_ID=upper(?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, sid);
            
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                branch = rs.getString("Branch");
            }
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return branch;
    }
    
    
    //check by email if email is registered 
    public User logUserf(String email) {
        User user = null;
        try {
            String query = "select * from user where EmailAdd=upper(?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setSid(rs.getString("ID"));
                user.setFname(rs.getString("FirstName"));
                user.setMname(rs.getString("MiddleName"));
                user.setLname(rs.getString("LastName"));
                user.setBatch(rs.getString("Batch"));
                user.setBranch(rs.getString("Branch"));
                user.setEmail(rs.getString("EmailAdd"));
                user.setPassword(rs.getString("Password"));
                user.setProfile(rs.getString("ProfilePhoto"));
                user.setDOB(rs.getString("DOB"));
                user.setGender(rs.getString("Gender"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean saveMsg(message msg)
    {
         boolean test = false;
        try{
            
            SessionFactory sf = FactoryPro.getFactory();
            
            Session ssn = sf.openSession();
            Transaction tscn = ssn.beginTransaction();
            ssn.save(msg);
            tscn.commit();
            ssn.close();
            test = true;
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return test;
    }
    
    public static List<message> getMessage(String email1,String email2){
        SessionFactory sf = FactoryPro.getFactory();  
        Session ssn = sf.openSession();
        Query query = ssn.createQuery("from message where (sendEmail=:email1 and ReceiveEmail=:email2) or (sendEmail=:email2 and ReceiveEmail=:email1) ORDER BY UNIX_TIMESTAMP(Date) ASC ");
        query.setString("email1", email1);
        query.setString("email2", email2);
        
        List<message> list = query.list();
        return list;
    }
    
    public ArrayList<String> getRecent(String email)
    {
        ArrayList<String> mail = new ArrayList<>();
        try {
            String query = "SELECT ReceiveEmail from message where sendEmail=UPPER(?) GROUP BY ReceiveEmail ORDER BY UNIX_TIMESTAMP(Date) DESC";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            
            ResultSet rs = pst.executeQuery();
            while(rs.next())
            {
                mail.add(rs.getString("ReceiveEmail"));
            }
            
            String q = "SELECT sendEmail from message where ReceiveEmail=UPPER(?) GROUP BY sendEmail ORDER BY UNIX_TIMESTAMP(Date) DESC";
            PreparedStatement pt = this.con.prepareStatement(q);
            pt.setString(1, email);
            
            ResultSet r = pt.executeQuery();
            while(r.next())
            {
                if(!mail.contains(r.getString("sendEmail")))
                    mail.add(r.getString("sendEmail"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return mail;
    }
    
    public List<User> getRecentUser(ArrayList<String> email)
    {
        List<User> user = new ArrayList<>();
        
        for(String i: email)
        {
            try{
                String q = "SELECT FirstName,LastName,EmailAdd,ProfilePhoto from user where EmailAdd=upper(?)";
                PreparedStatement pst = this.con.prepareStatement(q);
                pst.setString(1, i);

                ResultSet r = pst.executeQuery();
                if(r.next())
                {
                    User u = new User();
                    u.setFname(r.getString(1));
                    u.setLname(r.getString(2));
                    u.setEmail(r.getString(3));
                    u.setProfile(r.getString(4));
                    
                    user.add(u);
                }
            }catch(Exception e)
            {
                e.printStackTrace();
            }
        }
        return user;
    }
    
    public boolean savePost(post obj){
        boolean test = false;
        try{
            
            SessionFactory sf = FactoryPro.getFactory();
            
            Session ssn = sf.openSession();
            Transaction tscn = ssn.beginTransaction();
            ssn.save(obj);
            tscn.commit();
            ssn.close();
            test = true;
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return test;
    }
    
    public static List<post> getPost(){
        SessionFactory sf = FactoryPro.getFactory();  
        Session ssn = sf.openSession();
        Query query = ssn.createQuery("from post ORDER BY UNIX_TIMESTAMP(Date) DESC");
        List<post> list = query.list();
        return list;
    }
    
    public User getUserName(String email) {
        User user = null;
        try {
            String query = "select FirstName,LastName,ProfilePhoto from user where EmailAdd=upper(?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, email);
            
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setFname(rs.getString("FirstName"));
                user.setLname(rs.getString("LastName"));
                user.setProfile(rs.getString("ProfilePhoto"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public void saveAa(AboutAlumni aa) {
        try {
            //Insert register data to database
            String query = "insert into aboutalumni (UserID) values (upper(?))";

            PreparedStatement pt = this.con.prepareStatement(query);
            pt.setString(1, aa.getId());

            pt.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updateUserData(User user) {
        try {
            //Insert register data to database
            String query = "update user set MiddleName=upper(?),LastName=upper(?),Password=? where EmailAdd=upper(?)";

            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setString(1, user.getMname());
            pst.setString(2, user.getLname());
            pst.setString(3, user.getPassword());
            pst.setString(4, user.getEmail());
            

            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
     public boolean updateUserPhoto(User user) {
         boolean test = false;
        try {
            //Insert register data to database
            String query = "update user set ProfilePhoto=? where EmailAdd=upper(?)";

            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setString(1, user.getProfile());
            pst.setString(2, user.getEmail());
            

            pst.executeUpdate();
            test = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return test;
    }
    
    public void updateAlumniData(AboutAlumni aa) {
        try {
            //Insert register data to database
            String query = "update aboutalumni set Bio=?,Employment=?,Employmentdetail=?,City=upper(?),State=upper(?),Country=upper(?) where upper(UserID)=upper(?)";

            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, aa.getBio());
            pst.setString(2, aa.getCuremp());
            pst.setString(3, aa.getPastemp());
            pst.setString(4, aa.getCity());
            pst.setString(5, aa.getState());
            pst.setString(6, aa.getCountry());
            pst.setString(7, aa.getId());
            

            pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public AboutAlumni getAlumniData(User user) {
        
        AboutAlumni aa = null;
        try {
            String query = "select * from aboutalumni where UserID=upper(?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setString(1, user.getSid());
          

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                aa = new AboutAlumni();
                aa.setId(rs.getString("UserID"));
                aa.setBio(rs.getString("Bio"));
                aa.setCuremp(rs.getString("Employment"));
                aa.setPastemp(rs.getString("EmploymentDetail"));
                aa.setCity(rs.getString("City"));
                aa.setState(rs.getString("State"));
                aa.setCountry(rs.getString("Country"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return aa;
    }
    
    public boolean deleteUserPost(String id)
    {
        boolean test = false;
        try{
            String query = "delete from post where PostID=?";

            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setString(1, id);
            
            int row = pst.executeUpdate();
            test = true;
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return test;
    }
    
    public void reportPost(int PostID, String UserEmail){
        try {
            //Insert register data to database
            String query = "insert into reportpost(PostID,UserEmail) values(upper(?),upper(?))";

            PreparedStatement pt = this.con.prepareStatement(query);
            pt.setInt(1, PostID);
            pt.setString(2, UserEmail);

            pt.executeUpdate();
           
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public boolean ignoreUserPost(String id)
    {
        boolean test = false;
        try{
            String query = "delete from reportpost where PostID=?";

            PreparedStatement pst = this.con.prepareStatement(query);
            
            pst.setString(1, id);
            
            int row = pst.executeUpdate();
            test = true;
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return test;
    }
    
    //getReportedPost by perticular user for report Button
    public boolean userReportedPost(int pid, String email)
    {
        boolean test = false;
        
        try {
            String query = "select * from reportpost where PostID=(?) and UserEmail=upper(?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, pid);
            pst.setString(2, email);
          
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                test = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return test;
    }
    
    //to put reportedPost to bottom
    public boolean checkReportedPost(int pid)
    {
        boolean test = false;
        
        try{
            String query = "select * from reportpost where PostID=(?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            pst.setInt(1, pid);
          
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                test = true;
            }
            
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return test;
    }
    
    //get all reported Posts
    public List<post> getReportedPost()
    {
        List<Integer> Pid = new ArrayList<>();
        List<Integer> count = new ArrayList<>();
        List<post> posts = new ArrayList<>();
        
        try {
            //SELECT PostID,COUNT(UserEmail) FROM `reportpost` GROUP BY PostID
            String query = "select PostID,Count(UserEmail) AS Count from reportpost GROUP BY PostID ORDER BY UNIX_TIMESTAMP(Date) DESC";
            PreparedStatement pst = this.con.prepareStatement(query);

            ResultSet rs = pst.executeQuery();

            while(rs.next()) {
                Pid.add(rs.getInt("PostID"));
                count.add(rs.getInt("Count"));
            }
            
            int j=0;
            for(int i: Pid){
                String q = "select * from post where PostID = ?";
                
                PreparedStatement pt = this.con.prepareStatement(q);
                pt.setInt(1, i);
                
                ResultSet r = pt.executeQuery();
                if(r.next())
                {
                    post p = new post(r.getInt("PostID"), r.getString("EmailAdd"), r.getString("Text"), r.getString("Photo"), r.getTimestamp("Date"), r.getString("Type"));
                    p.setNoOfReport(count.get(j++));
                    posts.add(p);
                }
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return posts;
    }
    
    public List<User> getSearchedUser(String batch, String branch, String name)
    {
        List<User> u = new ArrayList<>();
        List<User> t1 = new ArrayList<>();        
        List<User> t2 = new ArrayList<>();        
        List<User> t3 = new ArrayList<>();
        int f1 = 0;
        int f2 = 0;
        int f3 = 0;
        int f = 0;
        String query = null;
        if(!branch.equals("none") && !batch.isEmpty())
            {
                query = "select ID, FirstName, MiddleName, LastName, Batch, Branch, EmailAdd, ProfilePhoto from user where Batch = '"+batch.trim()+"' AND Branch = '"+branch.trim()+"'";
                f = 1;
            }
            else if(branch.equals("none") && !batch.isEmpty())
            {
                query = "select ID, FirstName, MiddleName, LastName, Batch, Branch, EmailAdd, ProfilePhoto from user where Batch = '"+batch.trim()+"'";
                f = 1;
            }
            else if(!branch.equals("none") && batch.isEmpty())
            {
                query = "select ID, FirstName, MiddleName, LastName, Batch, Branch, EmailAdd, ProfilePhoto from user where Branch = '"+branch.trim()+"'";
                f = 1;
            }
        
        
        try {
            PreparedStatement pst;
            if(f == 1)
            {
                pst = this.con.prepareStatement(query);
            }
            else
            {
                System.out.println(name);
                query = "select ID, FirstName, MiddleName, LastName, Batch, Branch, EmailAdd, ProfilePhoto from user";
                pst = this.con.prepareStatement(query);
            }
            ResultSet rs = pst.executeQuery();

            int i = 0;
            while (rs.next()) {
                User temp = new User();
                temp.setSid(rs.getString(1));
                temp.setFname(rs.getString(2));
                temp.setMname(rs.getString(3));
                temp.setLname(rs.getString(4));
                temp.setBatch(rs.getString(5));
                temp.setBranch(rs.getString(6));
                temp.setEmail(rs.getString(7));
                temp.setProfile(rs.getString(8));
                
                u.add(temp);
            }
            
            for(User j: u)
            {
                if(name.contains(j.getFname()))
                {
                    f1= 1;
                    t1.add(j);
                }
            }
            if(f1 != 1)    t1 = u;
            
            for(User j: t1)
            {
                if(name.contains(j.getMname()))
                {
                    f2 = 1;
                    t2.add(j);
                }
            }
            if(f2 != 1)    t2 = t1;
            
            for(User j: t2)
            {
                if(name.contains(j.getLname()))
                {
                    f3 = 1;
                    t3.add(j);
                }
            }
            
            if(f3 != 1)    t3 = t2;
            
            if((f1 == 0) && (f2 == 0) && (f3 == 0))
                t3.clear();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return t3;
    }
}
