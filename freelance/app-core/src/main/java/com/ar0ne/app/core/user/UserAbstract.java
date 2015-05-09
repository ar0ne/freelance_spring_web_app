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
    private boolean enabled;
    
    private String  about;

    public abstract long getId();
    public abstract void setId(long id);
    public abstract String getPassword();
    public abstract void setPassword(String password);
    public abstract void setName(String name);
    public abstract void setLogin(String login);
    public abstract String getName();
    public abstract String getLogin();
    public abstract boolean isEnabled();
    public abstract void setEnabled(boolean enabled);
    
    public abstract void setAbout(String about);
    public abstract String getAbout();
    
    public abstract String toString(); 
}
