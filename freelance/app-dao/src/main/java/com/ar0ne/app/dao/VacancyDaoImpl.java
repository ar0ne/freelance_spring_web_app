package com.ar0ne.app.dao;

import com.ar0ne.app.core.request.Vacancy;
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



public class VacancyDaoImpl implements VacancyDao {
           
    NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    KeyHolder keyHolder = new GeneratedKeyHolder();
    
    public void setDataSource(DataSource dataSource) {
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }
  
    public class VacancyMapper implements RowMapper<Vacancy> {
        // (`ID` , `USER_ID` , `PAYMENT` , `TITLE` , `DESCRIPTION`, `DATE_ADDED` , `VACANCY_STATUS` ) 
        @Override
        public Vacancy mapRow(ResultSet rs, int i) throws SQLException {
            Vacancy vacancy = new Vacancy();
            vacancy.setId           (rs.getLong("ID"));
            vacancy.setUserId       (rs.getLong("USER_ID"));
            vacancy.setPayment      (rs.getString("PAYMENT"));
            vacancy.setTitle        (rs.getString("TITLE"));
            vacancy.setDescription  (rs.getString("DESCRIPTION"));
            vacancy.setDateAdded    (new LocalDateTime(rs.getTimestamp("DATE_ADDED")));
            vacancy.setStatus       (rs.getBoolean("VACANCY_STATUS"));
            return vacancy;
        }
    }

    @Override
    public List<Vacancy> getAllVacancys() {
        String sql = "SELECT * FROM vacancys";
        return namedParameterJdbcTemplate.query(sql, new VacancyMapper());
    }
    
    @Override
    public Vacancy findVacancyById(long vacancyId) {
        Map<String, Object> parameters = new HashMap(1);
        parameters.put("id", vacancyId);
        String sql = "SELECT * FROM vacancys WHERE ID = :id";
        // String sql = "SELECT vacancys.*, users.LOGIN FROM vacancys LEFT JOIN users ON vacancys.USER_ID = users.USER_ID WHERE ID = :id";
        return namedParameterJdbcTemplate.queryForObject(sql, parameters, new VacancyMapper());
    }
    
    @Override
    public void addVacancy(Vacancy vacancy) {
        SqlParameterSource parameterSource = new BeanPropertySqlParameterSource(vacancy);
        String sql = "INSERT INTO vacancys ( USER_ID , PAYMENT , TITLE , DESCRIPTION, DATE_ADDED , VACANCY_STATUS ) VALUES ( :userId, :payment, :title, :description, NOW(), :status)";
        namedParameterJdbcTemplate.update( sql, parameterSource, keyHolder);
        //return keyHolder.getKey().longValue();
    }
    
    @Override
    public void deleteVacancy(Long vacancyId) {
        Map<String, Object> parameters = new HashMap(1);
        parameters.put("id", vacancyId);
        String sql = "DELETE FROM vacancys  WHERE ID = :id";
        namedParameterJdbcTemplate.update( sql , parameters);
    }
    
    @Override
    public void updateUser(Vacancy vacancy) {
        Map<String, Object> parameters = new HashMap(2);
        
        parameters.put("id",            vacancy.getId());
        parameters.put("userId",        vacancy.getUserId());
        parameters.put("payment",       vacancy.getPayment());
        parameters.put("title",         vacancy.getTitle());
        parameters.put("description",   vacancy.getDescription());
        parameters.put("dateAdded",     new Timestamp(vacancy.getDateAdded().toDateTime().getMillis()));
        parameters.put("vacancyStatus", vacancy.getStatus());
        
        String sql = "UPDATE vacancys SET USER_ID = :userId, PAYMENT = :payment, TITLE = :title, DESCRIPTION = :description, DATE_ADDED = :dateAdded, VACANCY_STATUS = :vacancyStatus WHERE ID = :id";
        namedParameterJdbcTemplate.update( sql , parameters );
    }
    
    @Override
    public List<Vacancy> getAllUserVacancys(long userId) {
        
        Map<String, Object> parameters = new HashMap(2);
        parameters.put("userId", userId);
        
        //String sql = "SELECT users.NAME, vacancys.* FROM users LEFT JOIN vacancys ON vacancys.USER_ID = users.USER_ID WHERE vacancys.USER_ID = :userId";
        String sql = "SELECT * FROM vacancys WHERE USER_ID = :userId";
        return namedParameterJdbcTemplate.query(sql, parameters, new VacancyMapper());
    }
    
    @Override
    public List<Vacancy> getOpenVacancy() {
        String sql = "SELECT * FROM vacancys WHERE VACANCY_STATUS = 0";
        return namedParameterJdbcTemplate.query(sql, new VacancyMapper());
    }
    
    

    
    
}
