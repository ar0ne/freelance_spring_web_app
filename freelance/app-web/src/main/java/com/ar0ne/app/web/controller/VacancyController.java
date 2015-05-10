package com.ar0ne.app.web.controller;

import com.ar0ne.app.core.request.JobRequest;
import com.ar0ne.app.core.request.Vacancy;
import com.ar0ne.app.core.user.Client;
import com.ar0ne.app.core.user.UserAbstract;
import com.ar0ne.app.service.JobRequestService;
import com.ar0ne.app.service.UserService;
import com.ar0ne.app.service.VacancyService;
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


@Controller
public class VacancyController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private VacancyService vacancyService;
    
    @Autowired
    private JobRequestService jobRequestService;

    
    @RequestMapping(value = { "/findJob" }, method = RequestMethod.GET)
    public ModelAndView findJobPage() {
        
        ModelAndView modelAndView = new ModelAndView("findJob");
        
        List<Vacancy> vacancyList = vacancyService.getOpenVacancy();
        
        // limit all descriptions by 256 chars
        for(Vacancy vacancy : vacancyList) {
            String descr = vacancy.getDescription();
            vacancy.setDescription(descr.length() > 256 ? descr.substring(0, 256) + "..." : descr);
        }
        
        modelAndView.addObject("vacancyList", vacancyList);
        
        return modelAndView;
    }
    
    @RequestMapping(value = "/addVacancy", method = RequestMethod.GET)
    public ModelAndView addVacancyPage() {
        
        ModelAndView modelAndView = new ModelAndView("addVacancy");
        
        return modelAndView;
    }
    
    
    @RequestMapping(value = "/submitNewVacancy", method = RequestMethod.POST)
    public String addNewVacancyAction(  @RequestParam("title")          String   title,
                                        @RequestParam("description")    String   description,
                                        @RequestParam("payment")        String   payment ) {
        
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String login = auth.getName();

        if (login != null) {
            UserAbstract user = userService.findUserByLogin(login);
            if (user != null) {
        
                Vacancy vacancy = new Vacancy();
                vacancy.setPayment(payment);
                vacancy.setDescription(description);
                vacancy.setTitle(title);
                vacancy.setStatus(false);
                vacancy.setUserId(user.getId());

                vacancyService.addVacancy(vacancy);
            } else {
                System.out.println("User didn't find!");
            }
        } else {
            System.out.println("Problem with authentification!");
        }
        
        return "redirect:/userProfile";
    }
    
    
    // for ajax 
    @RequestMapping(value = "/deleteVacancy", method = RequestMethod.POST)
    public ResponseEntity deleteVacancyAction( @RequestParam("vacancyId") long vacancyId ) {
               
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String login = auth.getName();
        
        if (login != null) {
            Vacancy vacancy = vacancyService.findVacancyById(vacancyId);
            if( vacancy != null ) {
                if (login.equals(vacancy.getUserLogin())) {
                    // only author of vacancy can delete 
                    vacancyService.deleteVacancy(vacancyId);
                    return new ResponseEntity("", HttpStatus.OK);
                }
            }
        }
        return new ResponseEntity("", HttpStatus.NOT_FOUND);
    }
    
    
    
    @RequestMapping(value = "/addJobRequest", method = RequestMethod.POST)
    public ResponseEntity addJobRequestAction( @RequestParam("vacancyId") long   vacancyId,
                                               @RequestParam("comment")   String comment) {
               
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String login = auth.getName();
        
        if (login != null) {
            UserAbstract user = userService.findUserByLogin(login);
            
            // Check if user create request early and this is second
            List<JobRequest> jobRequests = jobRequestService.getUserJobRequests(user.getId());
            for(JobRequest request: jobRequests){
                if (request.getVacancyId() == vacancyId) {
                    return new ResponseEntity("You can create another job request for this vacancy!", HttpStatus.NOT_FOUND);
                }
            }
            
            Vacancy vacancy = vacancyService.findVacancyById(vacancyId);
            if (vacancy.getUserId() == user.getId()) {
                return new ResponseEntity("You can create Job Request for own vacancy!", HttpStatus.NOT_FOUND);
            }
            
            JobRequest request = new JobRequest();
            request.setUserId(user.getId());
            request.setVacancyId(vacancyId);
            request.setComment(comment);
            request.setStatus(false);
            
            jobRequestService.addJobRequest(request);
            return new ResponseEntity("", HttpStatus.OK);
        }
        
        return new ResponseEntity("Problem with authentification", HttpStatus.NOT_FOUND);
    }
    
    
    
    
    
    @RequestMapping(value = "/vacancy/{id}", method = RequestMethod.GET)
    public ModelAndView vacancyFullPage(@PathVariable("id") long vacancyId) {
        
        ModelAndView modelAndView = null;
        
        Vacancy vacancy = vacancyService.findVacancyById(vacancyId);
        
        if(vacancy == null) {
            System.out.println("Vacancy with id = " + vacancyId + " not found!");
            modelAndView = new ModelAndView("redirect:/userProfile");
        } else {
            modelAndView = new ModelAndView("vacancy");
            modelAndView.addObject("vacancy", vacancy);
            
            List<JobRequest> jobRequestList = jobRequestService.getVacancysJobRequests(vacancyId);
            modelAndView.addObject("jobRequestList", jobRequestList);

        }
        return modelAndView;
    }
    
    
    @RequestMapping(value = "/acceptRequest", method = RequestMethod.POST)
    public ResponseEntity addJobRequestAction( @RequestParam("vacancyId")   long    vacancyId,
                                               @RequestParam("requestId")   long    requestId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String login = auth.getName();

        if (login != null) {
            UserAbstract user = userService.findUserByLogin(login);
         
            if(user != null) {
                
                if(user instanceof Client) {
                    Client client = (Client)user;
                    List<Vacancy> vacancys = client.getVacancys();
                    for(Vacancy vacancy : vacancys) {
                        if(vacancy.getId() == vacancyId) {
                            vacancyService.acceptRequest(vacancyId, requestId);
                            return new ResponseEntity("", HttpStatus.OK);
                        }
                    }
                }
            }
        }
        
        return new ResponseEntity("Problem with authentification", HttpStatus.NOT_FOUND);
    }
    
}
