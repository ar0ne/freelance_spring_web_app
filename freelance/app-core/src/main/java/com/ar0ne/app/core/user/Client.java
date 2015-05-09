package com.ar0ne.app.core.user;

import com.ar0ne.app.core.request.*;
import java.util.List;

/**
 *
 * @author ar1
 */
public class Client extends UserAbstract{
    
    private long                id;
    private String              name;
    private String              login;
    private String              password;
    private boolean             enabled;
    
    private String              about;
    
    private List<Vacancy>       vacancys;
    private List<JobRequest>    jobs;
    
    public Client(){
    }
    
    public Client( String name, String login, String password, boolean enabled) {
        this.name =     name;
        this.login =    login;
        this.password = password;
        this.enabled =  enabled;
    }
    
    public Client(long id, String name, String login, String password, boolean enabled) {
        this.id = id;
        this.name = name;
        this.login = login;
        this.password = password;
        this.enabled = enabled;
    }

    public Client(long id, String name, String login, String password, boolean enabled, String about) {
        this.id =       id;
        this.name =     name;
        this.login =    login;
        this.password = password;
        this.enabled =  enabled;
        this.about =    about;
    }
    
    public Client(long id, String name, String login, String password, boolean enabled,
                List<Vacancy> vacancys,  
                List<JobRequest> jobs, 
                String about) {
        this.id =       id;
        this.name =     name;
        this.login =    login;
        this.password = password;
        this.vacancys = vacancys;
        this.jobs =     jobs;
        this.enabled =  enabled;
        this.about =    about;
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

    public List<JobRequest> getJobs() {
        return jobs;
    }

    public List<Vacancy> getVacancys() {
        return vacancys;
    }

    public void setJobs(List<JobRequest> jobs) {
        this.jobs = jobs;
    }

    public void setVacancys(List<Vacancy> vacancys) {
        this.vacancys = vacancys;
    }
    
    public void addVacancy(Vacancy v) {
        this.vacancys.add(v);
    }
    
    public void addJob(JobRequest j) {
        this.jobs.add(j);
    }

    @Override
    public boolean isEnabled() {
        return enabled;
    }

    @Override
    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }
    
    @Override
    public void setAbout(String about) {
        this.about = about;
    }

    @Override
    public String getAbout() {
        return about;
    }
    
    @Override
    public String toString() {
        return "Client["
                + " id: "        + this.id 
                + ", login: "    + this.login
                + ", name: "     + this.name
                + ", password: " + this.password
                + ", enabled: "  + this.enabled
                + " ]";
    }

}
