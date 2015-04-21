package com.ar0ne.app.service;

import com.ar0ne.app.dao.UserDao;

/**
 *
 * @author ar1
 */
public class UserServiceImpl implements UserService{

    private UserDao userDao;
    
    public void setMessageDao() {
        this.userDao = userDao;
    }
    
    @Override
    public void addUser() {
       // userDao.addUser(); // something like this
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
