package com.ar0ne.app.dao;

import com.ar0ne.app.core.user.*;
/**
 *
 * @author ar1
 */
public interface UserDao {
    public void addUser(UserAbstract user);
    public void deleteUser();
    public void updateUser();
    public void getAllUsers();
    public UserAbstract findUserById(int id);
}
