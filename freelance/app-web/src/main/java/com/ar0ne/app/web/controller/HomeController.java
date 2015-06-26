package com.ar0ne.app.web.controller;

import com.ar0ne.app.core.user.Admin;
import com.ar0ne.app.core.user.Client;
import com.ar0ne.app.core.user.UserAbstract;
import com.ar0ne.app.service.UserService;

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
    
    @RequestMapping(value = {"/index", "/"}, method = RequestMethod.GET)
    public ModelAndView indexPage() {
        
        ModelAndView view = new ModelAndView("fp/landingpage");
               
        return view;
    }
    
            
}
