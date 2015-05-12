Introducing
===============

This is simple web application for Freelancers.
Wrote on Java and [Spring Framework](http://spring.io).

### How to run

You must to create new database `spring_freelance` on your MySQL server and run `demo_init.sql` from the root of the project folder for initialization of demo data.

In [mvc-dispatcher-servlet.xml](http://github.com/ar0ne/freelance_spring_web_app/freelance/app-web/src/main/webapp/WEB-INF/mvc-dispatcher-servlet.xml) you must to add your login and password for MySQL server `57-58`

And also you can rename database (edit `56`).

#### Next you must to run Apache Tomcat Server:

`$ cd freelance`
`$ mvn tomcat:run`

When server is started you can see result in browser

`http://localhost:8080/app-web`

For accounts login and password you can look `demo_init.sql`.

For example admin account (admin: 123), user account(walter: pass)