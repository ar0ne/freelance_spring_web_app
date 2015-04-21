package com.ar0ne.app.core.user;

/**
 *
 * @author ar1
 */
public abstract class UserAbstract {
    
    private long    id;
    private String  name;
    private String  login;
    private String  password;

    public UserAbstract() {
    }
    
    public UserAbstract(long id, String name, String login, String password) {
        this.id = id;
        this.name = name;
        this.login = login;
        this.password = password;
    }

    public abstract long getId();
    public abstract void setId(long id);
    public abstract String getPassword();
    public abstract void setPassword(String password);
    public abstract void setName(String name);
    public abstract void setLogin(String login);
    public abstract String getName();
    public abstract String getLogin();
    
    public abstract String toString(); 
}
