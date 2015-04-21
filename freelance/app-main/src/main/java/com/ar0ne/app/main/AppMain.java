package com.ar0ne.app.main;

//import com.ar0ne.app.

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AppMain {
    
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Module.xml");

//        UserDao userDAO = (UserDao) context.getBean("userDAO");
//        UserAbstract user = new Client(1, "Serj", "ar1", "12345");
//        userDao.addUser(user);

//        UserAbstract user1 = userDao.findUserById(1);
//        System.out.println(user1);

    }
}
