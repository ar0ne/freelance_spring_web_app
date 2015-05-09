package com.ar0ne.app.web.controller;

import com.ar0ne.app.core.user.Admin;
import com.ar0ne.app.core.user.Client;
import com.ar0ne.app.core.user.UserAbstract;
import com.ar0ne.app.service.UserService;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
    
    @Autowired
    private UserService userService;     
    
    @RequestMapping(value = {"/index", "/"}, method = RequestMethod.GET)
    public ModelAndView indexPage() {
        
        List<UserAbstract> users = userService.getAllUsers();
        ModelAndView view = new ModelAndView("index", "users", users);
        //view.setViewName("index");
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String login = auth.getName();
        
        if(login != null) {
            UserAbstract user = userService.findUserByLogin(login);
            if (user != null) {
                String home_url = "";
                home_url += (user instanceof Client ? "/userProfile/" : "/adminProfile/");
                home_url += user.getId();

                view.addObject("user_home", home_url);
            }
        }
        
        return view;
    }
    
    
    @RequestMapping("/signUp")
    public String signUpPage() {
        return "signUp";
    }
    
    
//    @RequestMapping(value = "/login", method = RequestMethod.GET)
//    public ModelAndView login(
//            @RequestParam(value = "error", required = false) String error,
//            @RequestParam(value = "logout", required = false) String logout) {
//
//        ModelAndView model = new ModelAndView();
//        if (error != null) {
//            model.addObject("error", "Invalid username and password!");
//        }
//
//        if (logout != null) {
//            model.addObject("msg", "You've been logged out successfully.");
//        }
//        model.setViewName("login");
//
//        return model;
//
//    }
    
    @RequestMapping("/userProfile")
    public String userProfilePage() {
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String login = auth.getName();
        
        if(login != null) {
            UserAbstract user = userService.findUserByLogin(login);
            if (user != null) {
                return "redirect:/userProfile/" + user.getId();
            }
        }
        
        return "redirect:/index";
    }
    
    @RequestMapping("/logout")
    public String logoutAction() {
        SecurityContextHolder.clearContext();
        return "redirect:/index";
    }
    
    @RequestMapping(value = {"/userProfile/{id}"}, method = RequestMethod.GET)
    public ModelAndView userProfilePage(@PathVariable("id") long userId) {
        UserAbstract user = userService.findUserById(userId);
        
        ModelAndView modelAndView;
        
        if(user == null) {
            modelAndView = new ModelAndView("redirect:/userProfile");
        } else {
            modelAndView = new ModelAndView("userProfile");
            
            modelAndView.addObject("user", user);
            
            if (user instanceof Client) {
                Client client = (Client)user;
                modelAndView.addObject("vacancyList", client.getVacancys());
                modelAndView.addObject("jobRequestList", client.getJobs());
            }
            
            modelAndView.addObject("userId", userId);
        }
        
        return modelAndView;
    }
    
    
    @RequestMapping(value = {"/adminProfile/{id}"}, method = RequestMethod.GET)
    public ModelAndView adminProfilePage(@PathVariable("id") long userId) {
        UserAbstract user = userService.findUserById(userId);

        ModelAndView modelAndView = null;

        if (user == null) {
            modelAndView = new ModelAndView("redirect:/index");
        } else {
            modelAndView = new ModelAndView("adminProfile");
            modelAndView.addObject("user", user);

            modelAndView.addObject("userId", userId);

            List<UserAbstract> userList = userService.getAllUsers();
            modelAndView.addObject("userList", userList);
        }

        return modelAndView;
    }
    
    
    
    @RequestMapping(value = "/submitDataSignUp", method = RequestMethod.POST)
    public String signUpAction( @RequestParam("Name")       String userName,
                                @RequestParam("Login")      String userLogin,
                                @RequestParam("Password")   String userPassword) {

        UserAbstract user = userService.findUserByLogin(userLogin);
        
        if (user == null) {
            user = new Client( userName, userLogin, userPassword, true);
            userService.addUser(user);
            return "redirect:/login";
        }

        return "redirect:/signUp";
    }
    
    
    @RequestMapping(value="/userProfile/submitUpdateUserProfile", method = RequestMethod.POST)
    public String updateUserProfileAction(  @RequestParam("name")      String   userName,
                                            @RequestParam("login")     String   userLogin,
                                            @RequestParam("password")  String   userPassword,
                                            @RequestParam("id")        long     userId,
                                            @RequestParam("about")     String   userAbout) {
        
        userService.updateUser(new Client(userId, userName, userLogin, userPassword, true, userAbout));
        
        return "redirect:/userProfile/" + userId;
    }
    
    @RequestMapping(value = "/adminProfile/submitUpdateAdminProfile", method = RequestMethod.POST)
    public String updateAdminProfileAction(@RequestParam("name") String userName,
            @RequestParam("login") String userLogin,
            @RequestParam("password") String userPassword,
            @RequestParam("id") Integer userId) {

        userService.updateUser(new Admin(userId, userName, userLogin, userPassword, true));

        return "redirect:/adminProfile/" + userId;
    }
    
    
    
    
}
