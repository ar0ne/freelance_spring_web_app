package com.ar0ne.app.dao;

import com.ar0ne.app.core.request.JobRequest;
import com.ar0ne.app.core.request.Vacancy;
import com.ar0ne.app.core.user.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;


public class UserDaoImpl implements UserDao {
    
    private DataSource dataSource;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public void addUser(UserAbstract user) {
        String sql1 = "INSERT INTO users "
                + "(LOGIN, PASSWORD, NAME, ENABLED) VALUES (?, ?, ?, ?)";
        String sql2 = "INSERT INTO user_roles "
                + "(USER_ID, ROLE) VALUES (?, ?)";
        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            Statement statement = conn.createStatement();
            
            PreparedStatement ps = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
            
            ps.setString(1, user.getLogin());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getName());
            ps.setBoolean(4, true);
            
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
                    
            if (rs.next()) {
                user.setId(rs.getLong(1));
            }
            
            // add to user roles table
            ps = conn.prepareStatement(sql2);
            ps.setLong(1, user.getId());
            
            String role = (user instanceof Client) ? "ROLE_USER" : "ROLE_ADMIN";
            ps.setString(2, role);
            
            ps.executeUpdate();
            
            rs.close();
            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    
                }
            }
        }
    } 
    
    @Override
    public UserAbstract findUserById(long id) {
        String sql = "SELECT * FROM users LEFT JOIN user_roles ON users.USER_ID = user_roles.USER_ID WHERE users.USER_ID = ?";

        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);
            UserAbstract user = null;
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if("ROLE_ADMIN".equals(rs.getString("ROLE"))) {
                    user = new Admin(
                            rs.getLong("USER_ID"),
                            rs.getString("NAME"),
                            rs.getString("LOGIN"),
                            rs.getString("PASSWORD"),
                            rs.getBoolean("ENABLED"),
                            rs.getString("ABOUT")
                    );
                }else {
                    
                    VacancyDaoImpl vacancyDao = new VacancyDaoImpl();
                    vacancyDao.setDataSource(dataSource);
                    List<Vacancy> vacancys = vacancyDao.getAllUserVacancys(id);
                    
                    JobRequestDaoImpl jobRequestDao = new JobRequestDaoImpl();
                    jobRequestDao.setDataSource(dataSource);
                    List<JobRequest> jobRequests = jobRequestDao.getUserJobRequests(id);
                    
                    user = new Client(
                            rs.getLong("USER_ID"),
                            rs.getString("NAME"),
                            rs.getString("LOGIN"),
                            rs.getString("PASSWORD"),
                            rs.getBoolean("ENABLED"),
                            vacancys,
                            jobRequests,
                            rs.getString("ABOUT")
                    );
                    
                }
            }
            rs.close();
            ps.close();
            return user;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                }
            }
        }
    }
    
    
    @Override
    public UserAbstract findUserByLogin(String login) {
        String sql = "SELECT * FROM users LEFT JOIN user_roles ON users.USER_ID = user_roles.USER_ID WHERE users.LOGIN = ?";

        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, login);
            UserAbstract user = null;
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if("ROLE_ADMIN".equals(rs.getString("ROLE"))) {
                    user = new Admin(
                            rs.getLong("USER_ID"),
                            rs.getString("NAME"),
                            rs.getString("LOGIN"),
                            rs.getString("PASSWORD"),
                            rs.getBoolean("ENABLED"),
                            rs.getString("ABOUT")
                    );
                } else {
                    
                    VacancyDaoImpl vacancyDao = new VacancyDaoImpl();
                    vacancyDao.setDataSource(dataSource);
                    List<Vacancy> vacancys = vacancyDao.getAllUserVacancys(rs.getLong("USER_ID"));

                    JobRequestDaoImpl jobRequestDao = new JobRequestDaoImpl();
                    jobRequestDao.setDataSource(dataSource);
                    List<JobRequest> jobRequests = jobRequestDao.getUserJobRequests(rs.getLong("USER_ID"));
                    
                    user = new Client(
                            rs.getLong("USER_ID"),
                            rs.getString("NAME"),
                            rs.getString("LOGIN"),
                            rs.getString("PASSWORD"),
                            rs.getBoolean("ENABLED"),
                            vacancys,
                            jobRequests,
                            rs.getString("ABOUT")
                    );
                }
            }
            rs.close();
            ps.close();
            return user;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                }
            }
        }
    }
    

    @Override
    public void deleteUser(long id) {
        String sql = "DELETE u.*, r.* FROM users u LEFT JOIN user_roles r ON r.USER_ID = u.USER_ID WHERE u.USER_ID = ?";
        
        // @TODO: Delete his vacancys and requests??

        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);
            ps.execute();
            
            ps.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    
                }
            }
        }
    }

    @Override
    public void updateUser(UserAbstract user) {
        String sql = "UPDATE users SET LOGIN = ?, NAME = ?, PASSWORD = ?, ENABLED = ?, ABOUT = ? WHERE USER_ID = ?";

        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, user.getLogin());
            ps.setString(2, user.getName());
            ps.setString(3, user.getPassword());
            ps.setBoolean(4, user.isEnabled());
            ps.setString(5, user.getAbout());
            ps.setLong  (6, user.getId());
            
            ps.executeUpdate();
            
            ps.close();
            
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    
                }
            }
        }
    }

    @Override
    public List<UserAbstract> getAllUsers() {
        List<UserAbstract> users = new ArrayList<UserAbstract>();
        
        String sql = "SELECT * FROM users LEFT JOIN user_roles ON users.USER_ID = user_roles.USER_ID";

        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            UserAbstract user = null;
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                if("ROLE_ADMIN".equals(rs.getString("ROLE"))) {
                    user = new Admin(
                            rs.getLong("USER_ID"),
                            rs.getString("NAME"),
                            rs.getString("LOGIN"),
                            rs.getString("PASSWORD"),
                            rs.getBoolean("ENABLED")
                    );
                } else {
                    user = new Client(
                            rs.getLong("USER_ID"),
                            rs.getString("NAME"),
                            rs.getString("LOGIN"),
                            rs.getString("PASSWORD"),
                            rs.getBoolean("ENABLED")
                    );
                }
                
                users.add(user);
            }
            rs.close();
            ps.close();
            
            return users;
            
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                }
            }
        }       
    }
    
    
    @Override
    public void changeUserStatus(long userId, boolean status) {
        
        String sql = "UPDATE users SET ENABLED = ? WHERE USER_ID = ?";
        
        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setBoolean(1, status);
            ps.setLong   (2, userId);

            ps.executeUpdate();

            ps.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {

                }
            }
        }
    }

}
