package com.example.homework.service;

import com.example.homework.model.Statictics;
import com.example.homework.model.User;
import com.example.homework.repository.StatisticsRepo;
import com.example.homework.repository.UserRepo;
import com.example.homework.security.UserDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StatsService {
    @Autowired
    private UserRepo userRepo;

    @Autowired
    private StatisticsRepo statisticsRepo;

    public void saveStatSnippet(String countryName,
                                String date,
                                Integer totalCases,
                                Integer totalDeaths,
                                Integer newCases) {
        UserDetail userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String name = userDetail.getUsername();
        System.out.println("UserName : " + name);
        Optional<User> user = userRepo.findByName(name);
        if (user.isPresent()) {
            Optional<Statictics> oldStats = statisticsRepo.findByCountryNameAndUser_id(countryName,user.get().getId());
            if (oldStats.isPresent()) {
                oldStats.get().setDate(date);
                oldStats.get().setNewCases(newCases);
                oldStats.get().setTotalCases(totalCases);
                oldStats.get().setTotalDeaths(totalDeaths);
                statisticsRepo.save(oldStats.get());
            } else {
                Statictics stat = new Statictics();
                stat.setCountryName(countryName);
                stat.setDate(date);
                stat.setNewCases(newCases);
                stat.setTotalCases(totalCases);
                stat.setTotalDeaths(totalDeaths);
                user.get().getStatictics().add(stat);
                stat.setUser(user.get());
                statisticsRepo.save(stat);
                userRepo.save(user.get());
            }
        }

    }

    public List<User> getAllUsers() {
        return userRepo.findAll();
    }

    public void createUser(String username, String password, String role) {
        Optional<User> user = userRepo.findByName(username);
        if (!user.isPresent()) {
            User newUser = new User();
            newUser.setName(username);
            newUser.setPassword(password);
            newUser.setRole(role);
            userRepo.save(newUser);
        }

    }

    public void deleteUser(int id) {
        userRepo.deleteById(id);
    }
}
