/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.homework.controller;

import java.util.HashMap;
import java.util.Map;

import com.example.homework.model.User;
import com.example.homework.objects.*;
import com.example.homework.security.UserDetail;
import com.example.homework.service.StatsService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.PostConstruct;


@Controller
public class MainController {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private StatsService statsService;

    public static Map<String, String> countries;

    // method to fetch coutries names and keys when application is loaded.
    @PostConstruct
    public void getCountries() {
        countries = new HashMap<>();
        Object object = restTemplate.getForObject("https://api.covid19tracking.narrativa.com/api/countries", Object.class);
        new HashMap<>();
        if (object != null) {
            ObjectMapper objectMapper = new ObjectMapper();
            Country data = objectMapper.convertValue(object, Country.class);
            for (Country_ country : data.getCountries()) {
                countries.put(country.getId(), country.getName());
            }
        }
    }

    // main entry point when user gets authenticated 
    @RequestMapping(value = {"/"}, method = RequestMethod.GET)
    public ModelAndView allDonations(

    ) {
        ModelAndView model = new ModelAndView("index");
        model.addObject("countries", countries);
        return model;
    }

    // this method fetched data about a country by date and displays in jsp view
    @GetMapping(value = "/stats")
    public ModelAndView getCountryStats(
            @RequestParam("date") String date,
            @RequestParam("country") String country

    ) {
        System.out.println("Rreceived hit finally");
        System.out.println("date : " + date);
        System.out.println("Country : " + country);
        ModelAndView model = new ModelAndView("index");
        model.addObject("countries", countries);
        if (!date.isEmpty() && !country.isEmpty()) {
            Object object = restTemplate.getForObject("https://api.covid19tracking.narrativa.com/api/" + date + "/country/" + country, Object.class);
            if (object != null) {
                ObjectMapper mapper = new ObjectMapper();
                StatsMainWrapper mainStats = mapper.convertValue(object, StatsMainWrapper.class);
                model.addObject("stats", mainStats.getTotal());
                model.addObject("countryName", countries.get(country));
                System.out.println("Data : " + mainStats.getTotal());
            }
        }

        return model;
    }

    // this method returns login page
    @GetMapping("/loginView")
    public ModelAndView loginView() {
        User user = new User();
        ModelAndView modelAndView = new ModelAndView("login", "user", user);
        return modelAndView;
    }

    // this method saves stats data into database
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String saveStatsToDB(
            @RequestParam("countryName") String countryName,
            @RequestParam("date") String date,
            @RequestParam("totalCases") Integer totalCases,
            @RequestParam("totalDeaths") Integer totalDeaths,
            @RequestParam("newCases") Integer newCases
    ) {

        System.out.println("Did not received object");
        System.out.println("country : " + countryName);
        System.out.println("date : " + date);
        System.out.println("totalCases : " + totalCases);
        System.out.println("totalDeaths : " + totalDeaths);
        System.out.println("newCases : " + newCases);
        statsService.saveStatSnippet(countryName, date, totalCases, totalDeaths, newCases);
        return "redirect:/";
    }

    // this method returns jsp page of user management 
    @RequestMapping("/user/manage")
    public ModelAndView getUserManagementView() {
        ModelAndView model = new ModelAndView("userManage");
        model.addObject("users", statsService.getAllUsers());
        return model;
    }

    // this method is used to create new user if provided username doesn't exists
    @PostMapping("/create/user")
    public String createNewUser(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam("role") String role
    ) {
        System.out.println("username : " + username);
        System.out.println("password : " + password);
        System.out.println("role : " + role);
        statsService.createUser(username, password, role);
        return "redirect:/user/manage";
    }

    // this method deletes user from DB
    @PostMapping("/delete/user")
    public String deleteUser(
            @RequestParam("userId") int id
    ) {
        System.out.println("User Id : " + id);
        statsService.deleteUser(id);
        return "redirect:/user/manage";
    }

}
