package com.ar0ne.app.core.request;

import com.ar0ne.app.core.user.Client;

/**
 *
 * @author ar1
 */
public abstract class RequestAbstract {
    private int payment;
    private int hoursInWeek;
    private String requestName;
    private Client requester;

    public RequestAbstract() {
    }

    public RequestAbstract(int payment, int hoursInWeek, String requestName, Client requester) {
        this.payment = payment;
        this.hoursInWeek = hoursInWeek;
        this.requestName = requestName;
        this.requester = requester;
    }

    public int getHoursInWeek() {
        return hoursInWeek;
    }

    public int getPayment() {
        return payment;
    }

    public String getRequestName() {
        return requestName;
    }

    public Client getRequester() {
        return requester;
    }

    public void setHoursInWeek(int hoursInWeek) {
        this.hoursInWeek = hoursInWeek;
    }

    public void setPayment(int payment) {
        this.payment = payment;
    }

    public void setRequestName(String requestName) {
        this.requestName = requestName;
    }

    public void setRequester(Client requester) {
        this.requester = requester;
    }
    
    
}
