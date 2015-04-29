package com.ar0ne.app.dao;

import com.ar0ne.app.core.request.Vacancy;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.sql.DataSource;
import org.joda.time.LocalDateTime;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
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
            vacancy.setDataAdded    (new LocalDateTime(rs.getTimestamp("DATE_ADDED")));
            vacancy.setStatus       (rs.getBoolean("VACANCY_STATUS"));
            return vacancy;
        }
    }

    @Override
    public List<Vacancy> getAllVacancys() {
        String sql = "SELECT * FROM vacancys";
        return namedParameterJdbcTemplate.query(sql, new VacancyMapper());
    }

    
    
}
