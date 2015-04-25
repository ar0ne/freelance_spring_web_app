package com.ar0ne.app.common;

import com.ar0ne.app.core.user.Admin;
import com.ar0ne.app.core.user.Client;
import com.ar0ne.app.core.user.UserAbstract;
import com.ar0ne.app.dao.UserDao;
import java.util.List;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

class AppMain {
    
    public static void main(String[] args) {
        ApplicationContext context
                = new ClassPathXmlApplicationContext("Spring-Module.xml");

        UserDao userDao = (UserDao) context.getBean("userDao");
        
        System.out.println("Test: add new users");
        
        UserAbstract [] users = new UserAbstract[] {
            new Admin("Serj", "ar1", "123"),
            new Client("Jessi", "pinkman", "meth"),
            new Client("Walter W.", "big_boss", "money"),
            new Client("Jennifer", "jenny", "pass")
        };
        
        for(UserAbstract user : users) {
            userDao.addUser(user);
            System.out.println(user);
        }
        
        
        System.out.println("\nTest: find user by id");
        
        UserAbstract user1 = userDao.findUserById(users[3].getId());
        System.out.println(user1);
        
        System.out.println("\nTest: find user with login = pinkman");
        
        UserAbstract user2 = userDao.findUserByLogin("pinkman");
        System.out.println(user2);
        
        System.out.println("\nTest: update user - pinkman");
        user2.setName("Jessi Jackson");
        user2.setPassword("more_meth");
        userDao.updateUser(user2);
        
        UserAbstract user3 = userDao.findUserByLogin("pinkman");
        System.out.println(user3);
        
        
        System.out.println("\nTest: get All users");
        List<UserAbstract> list = userDao.getAllUsers();
        for (UserAbstract user : list) {
            System.out.println(user);
        }
        
        
//        System.out.println("\nTest: delete users");
//        
//        for (UserAbstract user : users) {
//            long id = user.getId();
//            System.out.println(user);
//            userDao.deleteUser(id);
//        }
        
        
        System.out.println("\nTest: find user by id");
        
        UserAbstract user4 = userDao.findUserById(users[3].getId());
        System.out.println(user4);
        
        
        
        
        
        



    }
}