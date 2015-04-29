package com.ar0ne.app.service;

import com.ar0ne.app.core.request.Vacancy;
import com.ar0ne.app.dao.VacancyDao;
import java.util.List;



public class VacancyServiceImpl implements VacancyService {
    
    private VacancyDao vacancyDao;

    public void setUserDao(VacancyDao vacancyDao) {
        this.vacancyDao = vacancyDao;
    }
    
    @Override
    public List<Vacancy> getAllVacancys() {
        List<Vacancy> vacancys = vacancyDao.getAllVacancys();
        return vacancys;
    }
    
}
