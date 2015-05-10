package com.ar0ne.app.dao;

import com.ar0ne.app.core.request.Vacancy;
import java.util.List;

public interface VacancyDao {
    
    public void addVacancy(Vacancy v);
    public void deleteVacancy(Long vacancyId);
    public void updateUser(Vacancy vacancy);
    public List<Vacancy> getAllVacancys();
    public List<Vacancy> getAllUserVacancys(long userId);
    public List<Vacancy> getOpenVacancy();
    public Vacancy findVacancyById(long vacancyId);
    public void acceptRequest(long vacancyId, long requestId);

}
