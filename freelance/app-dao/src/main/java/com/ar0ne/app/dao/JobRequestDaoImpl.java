package com.ar0ne.app.dao;

import com.ar0ne.app.core.request.JobRequest;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.sql.DataSource;
import org.joda.time.LocalDateTime;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;



public class JobRequestDaoImpl implements JobRequestDao {

    NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    KeyHolder keyHolder = new GeneratedKeyHolder();

    public void setDataSource(DataSource dataSource) {
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }
    
    public class JobRequestMapper implements RowMapper<JobRequest> {
        @Override
        public JobRequest mapRow(ResultSet rs, int i) throws SQLException {
            JobRequest jobRequest = new JobRequest();
            jobRequest.setId            (rs.getLong("ID"));
            jobRequest.setVacancyId     (rs.getLong("VACANCY_ID"));
            jobRequest.setUserId        (rs.getLong("USER_ID"));
            jobRequest.setComment       (rs.getString("COMMENT"));
            jobRequest.setDateAdded     (new LocalDateTime(rs.getTimestamp("DATE_ADDED")));
            jobRequest.setStatus        (rs.getBoolean("REQUEST_STATUS"));
            jobRequest.setUserLogin     (rs.getString("LOGIN"));
            return jobRequest;
        }
    }
    

    @Override
    public void addJobRequest(JobRequest jobRequest) {
        SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(jobRequest);
        String sql = "INSERT INTO job_requests ( VACANCY_ID, USER_ID , COMMENT , DATE_ADDED , REQUEST_STATUS ) VALUES ( :vacancyId, :userId, :comment, NOW(), :status)";
        namedParameterJdbcTemplate.update( sql, parameterSource, keyHolder);}

    @Override
    public void deleteJobRequest(long id) {
        Map<String, Object> parameters = new HashMap(1);
        parameters.put("id", id);
        String sql = "DELETE FROM job_requests  WHERE ID = :id";
        namedParameterJdbcTemplate.update( sql , parameters);
    }

    @Override
    public List<JobRequest> getAllJobRequests() {
        String sql = "SELECT job_requests.*, users.LOGIN FROM job_requests LEFT JOIN users ON users.USER_ID = job_requests.USER_ID";
        return namedParameterJdbcTemplate.query(sql, new JobRequestMapper());
    }

    @Override
    public void updateJobRequest(JobRequest jobRequest) {
        Map<String, Object> parameters = new HashMap(2);

        parameters.put("id", jobRequest.getId());
        parameters.put("vacancyId", jobRequest.getVacancyId());
        parameters.put("userId", jobRequest.getUserId());
        parameters.put("comment", jobRequest.getComment());
        parameters.put("dateAdded", new Timestamp(jobRequest.getDateAdded().toDateTime().getMillis()));
        parameters.put("status", jobRequest.getStatus());

        String sql = "UPDATE job_requests SET VACANCY_ID = :vacancyId, USER_ID = :userId, COMMENT = :comment, DATE_ADDED = :dateAdded, REQUEST_STATUS = :status WHERE job_requests.ID = :id";
        namedParameterJdbcTemplate.update(sql, parameters);
    }
    
    @Override
    public JobRequest findJobRequestById(long id) {
        Map<String, Object> parameters = new HashMap(1);
        parameters.put("id", id);
        String sql = "SELECT job_requests.*, users.LOGIN FROM job_requests LEFT JOIN users ON users.USER_ID = job_requests.USER_ID WHERE job_requests.ID = :id";
        return namedParameterJdbcTemplate.queryForObject(sql, parameters, new JobRequestMapper());
    }
    
    @Override
    public List<JobRequest> getVacancysJobRequests(long vacancyId) {
        Map<String, Object> parameters = new HashMap(1);
        parameters.put("vacancyId", vacancyId);
        String sql = "SELECT job_requests.*, users.LOGIN FROM job_requests LEFT JOIN users ON users.USER_ID = job_requests.USER_ID WHERE job_requests.VACANCY_ID = :vacancyId";
        return namedParameterJdbcTemplate.query(sql, parameters, new JobRequestMapper());
    }
    
    @Override
    public List<JobRequest> getUserJobRequests(long userId) {
        Map<String, Object> parameters = new HashMap(1);
        parameters.put("userId", userId);
        String sql = "SELECT job_requests.*, users.LOGIN FROM job_requests LEFT JOIN users ON users.USER_ID = job_requests.USER_ID WHERE job_requests.USER_ID = :userId";
        return namedParameterJdbcTemplate.query(sql, parameters, new JobRequestMapper());
    }
    
    
}
