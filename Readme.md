Introducing
===============

This is simple web application for Freelancers. Where users can add vacancies and take to vacancies of other users.
Application was wrote on Java and [Spring Framework 4.x](http://spring.io).

### Preparation

You must to create new database `spring_freelance` on your MySQL server and run a query `demo_init.sql` from the root of the project folder. It's create necessary tables and initializes of demo data.

Then you must add your login and password for MySQL server `57-58` in [mvc-dispatcher-servlet.xml](http://github.com/ar0ne/freelance_spring_web_app/freelance/app-web/src/main/webapp/WEB-INF/mvc-dispatcher-servlet.xml).

And also here you can rename database (edit `56`).

#### Run

It's maven project, and you can deploy it manually or on server. For example:

`$ cd freelance`
`$ mvn tomcat:run`

You can see result in browser: `http://localhost:8080/app-web`

You can register a new user or use demo users: : 

    - administrator account (admin: 123)
    - user account (walter: pass, pinkman: pass, jenny: pass)