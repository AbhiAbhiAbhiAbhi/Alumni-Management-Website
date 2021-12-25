/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

/**
 *
 * @author NJ
 */

@Entity
public class post {
    @Id  @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int PostID;
    @Column(name="EmailAdd")
    private String email;
    @Column(name="Text")
    private String text;
    @Column(name="Photo")
    private String photo;
    @Column(name="Date")
    private java.util.Date Date = new java.util.Date();
    @Column(name="Type")
    private String type;
    @Transient
    private int NoOfReport;
    public post() {
    }

    public post(String email, String text, String photo,String type) {
        this.email = email;
        this.text = text;
        this.photo = photo;
        this.type = type;
    }

    public post(int PostID, String email, String text, String photo, java.util.Date Date, String type) {
        this.PostID = PostID;
        this.email = email;
        this.text = text;
        this.photo = photo;
        this.Date = Date;
        this.type = type;
    }
    
    public int getPostID() {
        return PostID;
    }

    public void setPostID(int PostID) {
        this.PostID = PostID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getPhoto() {
        if(!photo.equals("none0000"))
            return photo.substring(64);
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getDate() {
        String date = Date.toString() ;
        return date.substring(0,16);
    }

    public void setDate(Date Date) {
        this.Date = Date;
    }
    
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getNoOfReport() {
        return NoOfReport;
    }

    public void setNoOfReport(int NoOfReport) {
        this.NoOfReport = NoOfReport;
    }
    

}
