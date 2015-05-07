package com.ar0ne.app.service;

import com.ar0ne.app.core.request.Vacancy;
import com.ar0ne.app.dao.VacancyDao;
import java.util.List;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.util.Assert;



public class VacancyServiceImpl implements VacancyService {
    
    private VacancyDao vacancyDao;

    public void setVacancyDao(VacancyDao vacancyDao) {
        this.vacancyDao = vacancyDao;
    }
    
    @Override
    public List<Vacancy> getAllVacancys() {
        List<Vacancy> vacancys = vacancyDao.getAllVacancys();
        return vacancys;
    }

    @Override
    public void addVacancy(Vacancy vacancy) {
        //Assert.isNull(vacancy.getId(),           "Vacancy ID must to be NULL");
        Assert.notNull(vacancy.getTitle(),       "Vacancy Title must to be Not NULL");
        Assert.notNull(vacancy.getDescription(), "Vacancy Description must to be Not NULL");
        
        vacancyDao.addVacancy(vacancy);
    }

    @Override
    public void deleteVacancy(Long vacancyId) {
        Assert.notNull(vacancyId,  "Vacancy Id can't be NULL");
        Vacancy vacancy = null;
        try {
            vacancy = vacancyDao.findVacancyById(vacancyId);
        } catch(EmptyResultDataAccessException ex) {
            throw new IllegalArgumentException("Vacancy with this ID doesn't exists!");
        }
        
        vacancyDao.deleteVacancy(vacancyId);
    }

    @Override
    public void updateUser(Vacancy vacancy) {
        Assert.notNull(vacancy.getId(),         "Vacancy Id can't be NULL");
        Assert.notNull(vacancy.getDateAdded(),  "Vacancy Date Added can't be NULL");
        Assert.notNull(vacancy.getDescription(),"Vacancy Description can't be NULL");
        Assert.notNull(vacancy.getTitle(),      "Vacancy Title can't be empty");
        Assert.notNull(vacancy.getUserId(),     "Vacancy UserId can't be empty");
        
        vacancyDao.updateUser(vacancy);
    }

    @Override
    public Vacancy findVacancyById(long vacancyId) {
        Assert.notNull(vacancyId);

        Vacancy vacancy = new Vacancy();
        try {
            vacancy = vacancyDao.findVacancyById(vacancyId);
        } catch (EmptyResultDataAccessException ex) {
            throw new IllegalArgumentException("Vacancy with this id doesn't exist");
        }
        return vacancy;
    }
    
    @Override
    public List<Vacancy> getAllUserVacancys(long userId) {
        Assert.notNull(userId);

        return vacancyDao.getAllUserVacancys(userId);
    }
    
    @Override
    public List<Vacancy> getOpenVacancy() {
        return vacancyDao.getOpenVacancy();
    }
    
}
