package com.ar0ne.app.core.request;

import org.joda.time.LocalDateTime;


public class JobRequest {
    
    private long            id;
    private long            vacancyId;
    private long            userId;
    private String          userLogin;
    private String          comment;
    private LocalDateTime   dateAdded;
    private boolean         status;

    public JobRequest() {
    }

    public JobRequest(long id, long vacancyId, long userId, String userLogin, 
                      String comment, LocalDateTime dateAdded, boolean status) {
        
        this.id =           id;
        this.vacancyId =    vacancyId;
        this.userId =       userId;
        this.comment =      comment;
        this.dateAdded =    dateAdded;
        this.status =       status;
        this.userLogin =    userLogin;
    }

    public String getComment() {
        return comment;
    }

    public LocalDateTime getDateAdded() {
        return dateAdded;
    }

    public long getId() {
        return id;
    }

    public long getUserId() {
        return userId;
    }

    public long getVacancyId() {
        return vacancyId;
    }
    
    public boolean getStatus() {
        return status;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public void setDateAdded(LocalDateTime dateAdded) {
        this.dateAdded = dateAdded;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    public void setVacancyId(long vacancyId) {
        this.vacancyId = vacancyId;
    }
    
    public void setUserLogin(String userLogin) {
        this.userLogin = userLogin;
    }

    public String getUserLogin() {
        return userLogin;
    }

    @Override
    public String toString() {
        return "JobRequest["
            + " id: "           + this.id
            + ", vacancyId: "   + this.vacancyId
            + ", userId: "      + this.userId
            + ", comment: "     + this.comment
            + ", dateAdded: "   + this.dateAdded
            + ", status: "      + this.status
            + " ]";
    }
    
    
    
    
}
