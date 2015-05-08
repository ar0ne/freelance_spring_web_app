package com.ar0ne.app.dao;

import com.ar0ne.app.core.request.JobRequest;
import java.util.List;

public interface JobRequestDao {
    
    public void addJobRequest(JobRequest jobRequest);
    public void deleteJobRequest(long id);
    public List<JobRequest> getAllJobRequests();
    public List<JobRequest> getVacancysJobRequests(long vacancyId);
    public void updateJobRequest(JobRequest jobRequest);
    public JobRequest findJobRequestById(long id);
    public List<JobRequest> getUserJobRequests(long userId);
    
            
}
