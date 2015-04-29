package com.ar0ne.app.web.controller;

import com.ar0ne.app.core.user.Admin;
import com.ar0ne.app.core.user.Client;
import com.ar0ne.app.core.user.UserAbstract;
import com.ar0ne.app.service.UserService;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
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
        
    @RequestMapping("/")
    public String init() {
        return "redirect:/index";
    }
    
    
    @RequestMapping("/index")
    public ModelAndView homePage() {
        
        List<UserAbstract> users = userService.getAllUsers();
        ModelAndView view = new ModelAndView("index", "users", users);
        
        return view;
    }
    
    @RequestMapping("/sign_in")
    public String signInPage() {
        return "sign_in";
    }
    
    @RequestMapping("/sign_up")
    public String signUpPage() {
        return "sign_up";
    }
    
    @RequestMapping(value = "/submitDataSignIn", method = RequestMethod.POST)
    public String signInAction(@RequestParam("Login")       String userLogin, 
                               @RequestParam("Password")    String userPassword ) {
        
        UserAbstract user = userService.findUserByLogin(userLogin);
        
        if (user != null && user.getPassword().equals( userPassword )) {
            return "redirect:/userProfile/" + user.getId();
        }
        
        return "redirect:/sign_in";
    }
    
    @RequestMapping("/userProfile")
    public String userProfile() {
        return "redirect:/sign_in";
    }
    
    @RequestMapping(value="/userProfile/{id}", method = RequestMethod.GET)
    public ModelAndView userProfilePage(@PathVariable("id") Long userId) {
        UserAbstract user = userService.findUserById(userId);
        
        ModelAndView modelAndView;
        
        if(user == null) {
            modelAndView = new ModelAndView("redirect:/sign_in");
        } else {
            modelAndView = new ModelAndView("userProfile");
            modelAndView.addObject("user", user);
            System.out.println(user);
            if (user instanceof Admin) {
                List<UserAbstract> userList = userService.getAllUsers();
                modelAndView.addObject("userList", userList);
            }
        }
        
        return modelAndView;
    }
    
    
    @RequestMapping(value = "/submitDataSignUp", method = RequestMethod.POST)
    public String signUpAction( @RequestParam("Name")       String userName,
                                @RequestParam("Login")      String userLogin,
                                @RequestParam("Password")   String userPassword) {

        UserAbstract user = userService.findUserByLogin(userLogin);

        if (user == null) {
            user = new Client(userName, userLogin, userPassword);
            userService.addUser(user);
            return "redirect:/userProfile/" + user.getId();
        }

        return "redirect:/sign_up";
    }
    
    
    @RequestMapping(value="/userProfile/submitUpdateUserProfile", method = RequestMethod.POST)
    public String updateUserProfileAction(  @RequestParam("name")      String   userName,
                                            @RequestParam("login")     String   userLogin,
                                            @RequestParam("password")  String   userPassword,
                                            @RequestParam("id")        Integer  userId) {
        
        // @TODO: what if this is Admin?
        userService.updateUser(new Client(userId, userName, userLogin, userPassword));
        
        return "redirect:/userProfile/" + userId;
    }

}
