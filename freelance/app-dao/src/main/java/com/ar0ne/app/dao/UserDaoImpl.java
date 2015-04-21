package com.ar0ne.app.dao;

import com.ar0ne.app.core.user.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.sql.DataSource;


public class UserDaoImpl implements UserDao {
    
    private DataSource dataSource;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public void addUser(UserAbstract user) {
        String sql = "INSERT INTO users "
                + "(LOGIN, PASSWORD, NAME) VALUES (?, ?, ?)";
        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            Statement statement = conn.createStatement();
            
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            ps.setString(1, user.getLogin());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getName());
            
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
                    
            if (rs.next()) {
                user.setId(rs.getLong(1));
            }
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
        String sql = "SELECT * FROM users WHERE USER_ID = ?";

        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong(1, id);
            UserAbstract user = null;
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new Client(
                        rs.getLong("USER_ID"),
                        rs.getString("NAME"),
                        rs.getString("LOGIN"),
                        rs.getString("PASSWORD")
                );
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
        String sql = "SELECT * FROM users WHERE LOGIN = ?";

        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, login);
            UserAbstract user = null;
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new Client(
                        rs.getLong  ("USER_ID"),
                        rs.getString("NAME"),
                        rs.getString("LOGIN"),
                        rs.getString("PASSWORD")
                );
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
        String sql = "DELETE FROM users WHERE USER_ID = ?";

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
        String sql = "UPDATE users SET LOGIN = ?, NAME = ?, PASSWORD = ? WHERE USER_ID = ?";

        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, user.getLogin());
            ps.setString(2, user.getName());
            ps.setString(3, user.getPassword());
            ps.setLong  (4, user.getId());
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
    public void getAllUsers() {
        
    }

}
