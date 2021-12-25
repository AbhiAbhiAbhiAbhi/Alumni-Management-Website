/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

/**
 *
 * @author DELL
 */
public class AboutAlumni {
    private String id;
    private String bio;
    private String curemp;
    private String pastemp;
    private String city;
    private String state;
    private String country;

    public AboutAlumni() {
    }

    public AboutAlumni(String id, String bio, String curemp, String pastemp, String city, String state, String country) {
        this.id = id;
        this.bio = bio;
        this.curemp = curemp;
        this.pastemp = pastemp;
        this.city = city;
        this.state = state;
        this.country = country;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getCuremp() {
        return curemp;
    }

    public void setCuremp(String curemp) {
        this.curemp = curemp;
    }

    public String getPastemp() {
        return pastemp;
    }

    public void setPastemp(String pastemp) {
        this.pastemp = pastemp;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
    
    
}
