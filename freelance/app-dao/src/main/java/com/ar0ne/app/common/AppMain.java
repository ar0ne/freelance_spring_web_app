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
        UserAbstract user = new Client(1, "Serj", "ar1", "123");
        userDAO.addUser(user);

        UserAbstract user1 = userDAO.findUserById(1);
        System.out.println(user1);

    }
}