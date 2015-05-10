package com.ar0ne.app.core.request;

import java.util.List;
import org.joda.time.LocalDateTime;


public class Vacancy {
    
    private long            id;
    private long            userId;
    private String          userLogin;
    private String          payment;
    private String          title;
    private String          description;
    private LocalDateTime   dateAdded;
    private boolean         status;
    
    private List<JobRequest> jobRequests;
    
    public Vacancy() {
    }

    public Vacancy(long id, long userId, String userLogin, String payment,
                   String title, String description, LocalDateTime dateAdded, 
                   boolean status) {
        
        this.id =           id;
        this.userId =       userId;
        this.payment =      payment;
        this.title =        title;
        this.description =  description;
        this.dateAdded =    dateAdded;
        this.status =       status;
        this.userLogin =    userLogin;
    }
    
    public Vacancy(long id, long userId, String userLogin, String payment, String title,
                   String description, LocalDateTime dateAdded, boolean status, 
                   List<JobRequest> jobRequests) {
        
        this.id =           id;
        this.userId =       userId;
        this.payment =      payment;
        this.title =        title;
        this.description =  description;
        this.dateAdded =    dateAdded;
        this.status =       status;
        this.userLogin =    userLogin;
        this.jobRequests =  jobRequests;
    }


    public LocalDateTime getDateAdded() {
        return dateAdded;
    }

    public String getDescription() {
        return description;
    }

    public long getId() {
        return id;
    }

    public String getPayment() {
        return payment;
    }

    public String getTitle() {
        return title;
    }

    public long getUserId() {
        return userId;
    }
    
    public boolean getStatus() {
        return status;
    }

    public void setDateAdded(LocalDateTime dateAdded) {
        this.dateAdded = dateAdded;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }
    
    public void setUserLogin(String userLogin) {
        this.userLogin = userLogin;
    }
    
    public String getUserLogin() {
        return userLogin;
    }
    
    public void setJobRequests(List<JobRequest> jobs) {
        this.jobRequests = jobs;
    }
    
    public List<JobRequest> getJobRequests() {
        return jobRequests;
    }

    @Override
    public String toString() {
        return "Vacancy[" 
            + " id: " + this.id 
            + ", user_id: " + this.userId 
            + ", payment: " + this.payment
            + ", title: " + this.title
            + ", description: " + this.description
            + ", date_added: " + this.dateAdded
            + ", status: " + this.status
            + " ]";
    }

    
 
    
    
    
}
