package com.ar0ne.app.core.user;

/**
 *
 * @author ar1
 */
public class Admin extends UserAbstract {
    
    private Long id;
    private String name;
    private String login;
    private String password;
    
    @Override
    public Long getId() {
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
    public void setId(Long id) {
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
                + "login: " + this.login
                + ",name: " + this.name
                + ",password: " + this.password
                + " ]";
    }

    
}
