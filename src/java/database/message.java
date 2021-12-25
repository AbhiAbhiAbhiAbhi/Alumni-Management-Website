
package database;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class message {
    @Id  @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int MessageID;
    private String sendEmail;
    private String receiveEmail;
    private String Chat;
    private java.util.Date Date = new java.util.Date();

    public message() {
    }

    public message(String sendEmail, String receiveEmail, String Chat) {
        this.sendEmail = sendEmail;
        this.receiveEmail = receiveEmail;
        this.Chat = Chat;
    }

    public int getMessageID() {
        return MessageID;
    }

    public void setMessageID(int MessageID) {
        this.MessageID = MessageID;
    }

    public String getSendEmail() {
        return sendEmail;
    }

    public void setSendEmail(String sendEmail) {
        this.sendEmail = sendEmail;
    }

    public String getReceiveEmail() {
        return receiveEmail;
    }

    public void setReceiveEmail(String receiveEmail) {
        this.receiveEmail = receiveEmail;
    }

    public String getChat() {
        return Chat;
    }

    public void setChat(String Chat) {
        this.Chat = Chat;
    }

    public Date getDate() {
        return Date;
    }

    public void setDate(Date Date) {
        this.Date = Date;
    }
    
    
}
