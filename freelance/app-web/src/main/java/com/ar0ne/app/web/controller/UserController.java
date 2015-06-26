package com.ar0ne.app.web.controller;

import com.ar0ne.app.core.user.Admin;
import com.ar0ne.app.core.user.Client;
import com.ar0ne.app.core.user.UserAbstract;
import com.ar0ne.app.service.UserService;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;  
    
    @RequestMapping(value = "/user/login", method = RequestMethod.GET)
    public ModelAndView login(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "logout", required = false) String logout) {

        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "Invalid username and password!");
        }

        if (logout != null) {
            model.addObject("msg", "You've been logged out successfully.");
        }
        model.setViewName("fp/user/login");

        return model;

    }

    @RequestMapping("/user/logout")
    public String logout() {
        SecurityContextHolder.clearContext();
        return "redirect:/index";
    }
    
    @RequestMapping("/user/details")
    public String userProfilePage() {
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String login = auth.getName();
        
        if(login != null) {
            UserAbstract user = userService.findUserByLogin(login);
            if (user != null) {
                return "redirect:/user/details/" + user.getId();
            }
        }
        
        return "redirect:/index";
    }
    
    
    @RequestMapping(value = {"/user/details/{id}"}, method = RequestMethod.GET)
    public ModelAndView userProfilePage(@PathVariable("id") long userId) {

        UserAbstract user = userService.findUserById(userId);
        
        ModelAndView modelAndView;
        
        if(user == null) {
            modelAndView = new ModelAndView("redirect:/user/details");
        } else {
            modelAndView = new ModelAndView("fp/user/details");
            
            modelAndView.addObject("user", user);
            
            if (user instanceof Client) {
                Client client = (Client)user;
                modelAndView.addObject("myVacancyList", client.getVacancys());
                modelAndView.addObject("myJobRequestList", client.getJobs());
            } else if(user instanceof Admin) {
                List<UserAbstract> userList = userService.getAllUsers();
                modelAndView.addObject("userList", userList);
            }
            
            modelAndView.addObject("userId", userId);
        }
        
        return modelAndView;
    }


    @RequestMapping(value = "/user/sign_up", method = RequestMethod.GET)
    public String signUpPage() {
        return "fp/user/signUp";
    }

    
    @RequestMapping(value = "/user/sign_up", method = RequestMethod.POST)
    public String signUpAction( @RequestParam("Name")       String userName,
                                @RequestParam("Login")      String userLogin,
                                @RequestParam("Password")   String userPassword) {

        UserAbstract user = userService.findUserByLogin(userLogin);

        if (user == null) {
            user = new Client( userName, userLogin, passwordEncoder.encode(userPassword), true);
            userService.addUser(user);
            return "redirect:/user/login";
        }

        return "redirect:/user/sign_up";
    }
    
    
    @RequestMapping(value="/user/details/update", method = RequestMethod.POST)
    public String updateUserProfileAction(  @RequestParam("name")      String   userName,
                                            @RequestParam("login")     String   userLogin,
                                            @RequestParam("password")  String   userPassword,
                                            @RequestParam("id")        long     userId,
                                            @RequestParam("about")     String   userAbout) {
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String login = auth.getName();

        if (login != null) {
            UserAbstract user = userService.findUserByLogin(login);
            if (user != null) {
                if(user instanceof Client) {
                    userService.updateUser(new Client(userId, userName, userLogin, userPassword, true, userAbout));
                } else if(user instanceof Admin) {
                    userService.updateUser(new Admin (userId, userName, userLogin, userPassword, true, userAbout));
                }
            }
        }
        return "redirect:/user/details/" + userId;
    }
    
    
    
    @RequestMapping(value = "/user/details/changeUserStatus", method = RequestMethod.POST)
    public ResponseEntity changeUserStatusAction(@RequestParam("userId")    long userId ) {
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String login = auth.getName();

        if (login != null) {
            UserAbstract user = userService.findUserByLogin(login);
            if (user != null) {
                if (user instanceof Admin) {
                    userService.changeUserStatus(userId);
                    return new ResponseEntity("", HttpStatus.OK);
                }
            }
        }
        
        return new ResponseEntity("Error: problem with authentification", HttpStatus.NOT_FOUND);
    }

}