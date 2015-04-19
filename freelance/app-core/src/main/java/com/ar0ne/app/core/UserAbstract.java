package com.ar0ne.app.core;

/**
 *
 * @author ar1
 */
public abstract class UserAbstract {
    private String name;
    private String login;
    private String password;

    public UserAbstract(String name, String login, String password) {
        this.name = name;
        this.login = login;
        this.password = password;
    }

    public UserAbstract() {
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getName() {
        return name;
    }

    public String getLogin() {
        return login;
    }
}
