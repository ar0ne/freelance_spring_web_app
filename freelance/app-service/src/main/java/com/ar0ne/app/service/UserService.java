package com.ar0ne.app.service;

import com.ar0ne.app.core.user.UserAbstract;
import java.util.List;

/**
 *
 * @author ar1
 */
public interface UserService {
    
    public void addUser(UserAbstract user);
    public void deleteUser(long id);
    public void updateUser(UserAbstract user);
    public List<UserAbstract> getAllUsers();
    public UserAbstract findUserById(long id);
    public UserAbstract findUserByLogin(String login);
    public void changeUserStatus(long userId);
    
}
