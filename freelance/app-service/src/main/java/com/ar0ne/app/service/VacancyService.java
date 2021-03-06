package com.ar0ne.app.service;

import com.ar0ne.app.core.request.Vacancy;
import java.util.List;


public interface VacancyService {

    public void addVacancy(Vacancy v);
    public void deleteVacancy(Long vacancyId);
    public void updateUser(Vacancy vacancy);
    public List<Vacancy> getAllVacancys();
    public Vacancy findVacancyById(long vacancyId);
    public List<Vacancy> getAllUserVacancys(long userId);
    public List<Vacancy> getOpenVacancy();
    public void acceptRequest(long vacancyId, long requestId);
    
}
