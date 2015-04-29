package com.ar0ne.app.service;

import com.ar0ne.app.core.user.UserAbstract;
import com.ar0ne.app.dao.UserDao;
import java.util.List;
import org.springframework.util.Assert;

/**
 *
 * @author ar1
 */
public class UserServiceImpl implements UserService{

    private UserDao userDao;
    
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }
    
    @Override
    public void addUser(UserAbstract user) {
        Assert.isNull(user.getId(), "user Id must to be NULL");
        Assert.notNull(user.getLogin(), "user login can't be empty");
        Assert.notNull(user.getName(), "User name can't be empty");
        Assert.notNull(user.getPassword(), "User password can't be empty");
        
        UserAbstract existing_user = userDao.findUserByLogin(user.getLogin());
        if(existing_user != null) {
            throw new IllegalArgumentException("user with same login exist: " + user.getLogin());
        }
        
        userDao.addUser(user);
    }

    @Override
    public void deleteUser(long id){
        Assert.notNull(id);
        UserAbstract user = userDao.findUserById(id);
        if(user == null) {
            throw new IllegalArgumentException("user not exists!" + id);
        }
        userDao.deleteUser(id);
    }

    @Override
    public void updateUser(UserAbstract user){
        Assert.notNull(user.getId(), "user Id can't be NULL");
        Assert.notNull(user.getLogin(), "user Login can't be empty");
        Assert.notNull(user.getName(), "user Name can't be empty");
        Assert.notNull(user.getPassword(), "user Password can't be empty");
        
        UserAbstract ex_user = userDao.findUserByLogin(user.getLogin());
        if (ex_user != null && ex_user.getId() != user.getId()) {
            throw new IllegalArgumentException("user with the same Login exists!" + user.getLogin());
        }
        
        userDao.updateUser(user);
    }

    @Override
    public List<UserAbstract> getAllUsers(){
        List<UserAbstract> users = userDao.getAllUsers();
        Assert.notEmpty(users, "Empty list of users!");
        return users;
    }

    @Override
    public UserAbstract findUserById(long id){
        Assert.notNull(id, "User Id can't be NULL");
        UserAbstract user = null;
        try {
          user = userDao.findUserById(id);
        } catch(Exception ex) {
            throw new IllegalArgumentException("User with this id doesn't exist");
        }
        
        return user;
    }

    @Override
    public UserAbstract findUserByLogin(String login){
        Assert.notNull(login, "User LOGIN can't be empty");
        UserAbstract user = null;
        try {
            user = userDao.findUserByLogin(login);
        } catch (Exception ex) {
            throw new IllegalArgumentException("User with this LOGIN doesn't exist");
        }

        return user;
    }

}
