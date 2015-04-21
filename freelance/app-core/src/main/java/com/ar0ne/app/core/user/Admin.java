package com.ar0ne.app.core.user;

/**
 *
 * @author ar1
 */
public class Admin extends UserAbstract {
    
    private long id;
    private String name;
    private String login;
    private String password;
    
    public Admin() {
    }
    
    public Admin(String name, String login, String password) {
        this.name = name;
        this.login = login;
        this.password = password;
    }

    public Admin(long id, String name, String login, String password) {
        this.id = id;
        this.name = name;
        this.login = login;
        this.password = password;
    }
    
    @Override
    public long getId() {
        return id;
    }

    @Override
    public String getLogin() {
        return login;
    }

    @Override
    public String getName() {
        return name;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public void setId(long id) {
        this.id = id;
    }

    @Override
    public void setLogin(String login) {
        this.login = login;
    }

    @Override
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public void setPassword(String password) {
        this.password = password;
    }
    
    @Override
    public String toString() {
        return "Admin["
                +" id: " + this.id
                + " ,login: " + this.login
                + " ,name: " + this.name
                + " ,password: " + this.password
                + " ]";
    }

    
}
