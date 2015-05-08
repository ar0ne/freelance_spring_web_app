package com.ar0ne.app.service;

import com.ar0ne.app.core.request.JobRequest;
import com.ar0ne.app.dao.JobRequestDao;
import java.util.List;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.util.Assert;



public class JobRequestServiceImpl implements JobRequestService {

    private JobRequestDao jobRequestDao;

    public void setJobRequestDao(JobRequestDao jobRequestDao) {
        this.jobRequestDao = jobRequestDao;
    }

    @Override
    public void addJobRequest(JobRequest jobRequest) {
        Assert.notNull(jobRequest, "Job Request not initialized!");
        jobRequestDao.addJobRequest(jobRequest);
    }

    @Override
    public void deleteJobRequest(long id) {
        Assert.notNull(id, "Job Request can't be NULL");
        JobRequest jobRequest = null;
        
        try {
            jobRequest = jobRequestDao.findJobRequestById(id);
        } catch(EmptyResultDataAccessException ex) {
            throw new IllegalArgumentException("Job Request with this ID doesn't exists!");
        }
        
        jobRequestDao.deleteJobRequest(id);
    }

    @Override
    public List<JobRequest> getAllJobRequests() {
        List<JobRequest> jobRequests = jobRequestDao.getAllJobRequests();
        return jobRequests;
    }

    @Override
    public void updateJobRequest(JobRequest jobRequest) {
        Assert.notNull(jobRequest.getId(), "JobRequest Id can't be NULL");
        Assert.notNull(jobRequest.getVacancyId(), "JobRequest Vacancy Id can't be NULL");
        Assert.notNull(jobRequest.getUserId(), "JobRequest UserId can't be empty");
        Assert.notNull(jobRequest.getDateAdded(), "JobRequest Date Added can't be NULL");
        
        jobRequestDao.updateJobRequest(jobRequest);
    }

    @Override
    public JobRequest findJobRequestById(long id) {
        Assert.notNull(id, "Job request can't be NULL");

        JobRequest jobRequest = new JobRequest();
        try {
            jobRequest = jobRequestDao.findJobRequestById(id);
        } catch (EmptyResultDataAccessException ex) {
            throw new IllegalArgumentException("JobRequest with this id doesn't exist");
        }
        return jobRequest;
    }
    
    @Override
    public List<JobRequest> getVacancysJobRequests(long vacancyId) {
        List<JobRequest> jobRequests = jobRequestDao.getVacancysJobRequests(vacancyId);
        return jobRequests;
    }
    
    
    @Override
    public List<JobRequest> getUserJobRequests(long userId) {
        List<JobRequest> jobRequests = jobRequestDao.getUserJobRequests(userId);
        return jobRequests;
    }
}
