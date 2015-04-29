package com.ar0ne.app.dao;

import javax.sql.DataSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;



public class JobRequestDaoImpl implements JobRequestDao {

    NamedParameterJdbcTemplate namedParameterJdbcTemplate;
    KeyHolder keyHolder = new GeneratedKeyHolder();

    public void setDataSource(DataSource dataSource) {
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }
}
