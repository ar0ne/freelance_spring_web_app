package com.ar0ne.app.dao;

import com.ar0ne.app.core.user.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;


public class UserDaoImpl implements UserDao {
    
    private DataSource dataSource;

    public void setDataSource(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @Override
    public void addUser(UserAbstract user) {
        String sql = "INSERT INTO users "
                + "(USER_ID, LOGIN, PASSWORD, NAME) VALUES (?, ?, ?, ?)";
        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setLong  (1, user.getId());
            ps.setString(2, user.getLogin());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getName());
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
    public UserAbstract findUserById(int id) {
        String sql = "SELECT * FROM users WHERE USER_ID = ?";

        Connection conn = null;

        try {
            conn = dataSource.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
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
    public void deleteUser() {
        
    }

    @Override
    public void updateUser() {
        
    }

    @Override
    public void getAllUsers() {
        
    }

}
