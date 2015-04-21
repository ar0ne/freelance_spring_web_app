package com.ar0ne.app.common;

import com.ar0ne.app.core.user.Client;
import com.ar0ne.app.core.user.UserAbstract;
import com.ar0ne.app.dao.UserDao;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

class AppMain {
    
    public static void main(String[] args) {
        ApplicationContext context
                = new ClassPathXmlApplicationContext("Spring-Module.xml");

        UserDao userDAO = (UserDao) context.getBean("userDAO");
        
        System.out.println("Test: add new users");
        
        UserAbstract [] users = new Client[] {
            new Client("Serj", "ar1", "123"),
            new Client("Jessi", "pinkman", "meth"),
            new Client("Walter W.", "big_boss", "money"),
            new Client("Jennifer", "jenny", "pass")
        };
        
        for(UserAbstract user : users) {
            userDAO.addUser(user);
            System.out.println(user);
        }
        
        
        System.out.println("\nTest: find user by id");
        
        UserAbstract user1 = userDAO.findUserById(users[3].getId());
        System.out.println(user1);
        
        System.out.println("\nTest: find user with login = pinkman");
        
        UserAbstract user2 = userDAO.findUserByLogin("pinkman");
        System.out.println(user2);
        
        System.out.println("\nTest: update user - pinkman");
        user2.setName("Jessi Jackson");
        user2.setPassword("more_meth");
        userDAO.updateUser(user2);
        
        UserAbstract user3 = userDAO.findUserByLogin("pinkman");
        System.out.println(user3);
        
        System.out.println("\nTest: delete users");
        
        for (UserAbstract user : users) {
            long id = user.getId();
            System.out.println(user);
            userDAO.deleteUser(id);
        }
        
        
        System.out.println("\nTest: find user by id");
        
        UserAbstract user4 = userDAO.findUserById(users[3].getId());
        System.out.println(user4);
        
        
        
        
        
        
        
        



    }
}