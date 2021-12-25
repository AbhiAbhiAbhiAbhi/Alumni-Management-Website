package database;

public class User {

    private String fname;
    private String mname;
    private String lname;
    private String batch;
    private String branch;
    private String sid;
    private String email;
    private String password;
    private String DOB;
    private String gender;
    private String Status;
    private String code;
    private String profile;

    public User() {
    }

    public User(String sid,String fname, String mname, String lname,  String email, String password, String DOB, String gender, String profile) {
        this.fname = fname;
        this.mname = mname;
        this.lname = lname;
        this.sid = sid;
        this.email = email;
        this.password = password;
        this.DOB = DOB;
        this.gender = gender;
        this.profile = profile;
    }
    
    public User(String sid, String fname, String mname, String lname, String batch, String branch, String email, String password, String DOB, String gender) {
        this.sid = sid;
        this.fname = fname;
        this.mname = mname;
        this.lname = lname;
        this.batch = batch;
        this.branch = branch;
        this.email = email;
        this.password = password;
        this.DOB = DOB;
        this.gender = gender;
    }
    
    
    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }
    
    public String getMname() {
        return mname;
    }

    public void setMname(String mname) {
        this.mname = mname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getBatch() {
        return batch;
    }

    public void setBatch(String batch) {
        this.batch = batch;
    }

    public String getBranch() {
        return branch;
    }

    public void setBranch(String branch) {
        this.branch = branch;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDOB() {
        return DOB;
    }

    public void setDOB(String DOB) {
        this.DOB = DOB;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String Status) {
        this.Status = Status;
    }

    
    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }
    
    
    public String getEditedEmail() {
        String email = this.email;
        int i=0;
        String tmp = null;
        while(i!=email.length())
        {
            if(!(email.substring(i, i+1).equals("@") || email.substring(i, i+1).equals(".")))
                if(tmp==null)
                    tmp = email.substring(i, i+1);
                else
                    tmp+=email.substring(i, i+1);
            i++;
        }        
        return tmp;
    }
}
