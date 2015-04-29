package com.ar0ne.app.service;

import com.ar0ne.app.dao.JobRequestDao;



public class JobRequestServiceImpl implements JobRequestService {

    private JobRequestDao jobRequestDao;

    public void setJobRequestDao(JobRequestDao jobRequestDao) {
        this.jobRequestDao = jobRequestDao;
    }
    
}
