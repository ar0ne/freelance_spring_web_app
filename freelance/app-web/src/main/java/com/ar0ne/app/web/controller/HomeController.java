package com.ar0ne.app.web.controller;

import com.ar0ne.app.core.user.UserAbstract;
import com.ar0ne.app.service.UserService;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
    
    @Autowired
    private UserService userService;
        
    @RequestMapping("/")
    public String init() {
        return "redirect:/home";
    }
    
    @RequestMapping(value= "/hello", method = RequestMethod.GET)
    public String helloWorld(ModelMap model) {
        model.addAttribute("message", "Hello World!!!");
        return "hello";
    }
    
    @RequestMapping("/home")
    public ModelAndView homePage() {
        
        List<UserAbstract> users = userService.getAllUsers();
        ModelAndView view = new ModelAndView("home", "users", users);
        
        return view;
    }
    
    
    
    
    
    

}
