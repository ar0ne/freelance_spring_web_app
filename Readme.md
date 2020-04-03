Introducing
===============

This is simple web application for Freelancers. Where users can add vacancies and take to vacancies of other users.
Application was written on Java and [Spring Framework 4.x](http://spring.io).

### Preparation

You must create new database `spring_freelance` on your MySQL server and run a query `demo_init.sql` from the root folder of the project. It will create necessary tables and initialize demo data.

Then you must add your login and password for MySQL server `57-58` in [mvc-dispatcher-servlet.xml](http://github.com/ar0ne/freelance_spring_web_app/freelance/app-web/src/main/webapp/WEB-INF/mvc-dispatcher-servlet.xml).

#### Run

`$ cd freelance`
`$ mvn tomcat:run`

You can see result in your browser on page: `http://localhost:8080/app-web`

You can register new user or use predefined: : 

    - administrator account (admin: 123)
    - user account (walter: pass, pinkman: pass, jenny: pass)
