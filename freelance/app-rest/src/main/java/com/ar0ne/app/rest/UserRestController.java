package com.ar0ne.app.rest;

import com.ar0ne.app.core.user.UserAbstract;
import com.ar0ne.app.service.UserService;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/users")
public class UserRestController {

    @Resource
    private UserService userService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
    
    @ResponseBody
    @RequestMapping(method = RequestMethod.GET)
    public ResponseEntity<List<UserAbstract>> getUsers() {
        List users = userService.getAllUsers();
        return new ResponseEntity(users, HttpStatus.OK);
    }
    
    
}
