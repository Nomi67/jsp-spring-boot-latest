package com.example.homework.service;

import com.example.homework.model.Statictics;
import com.example.homework.model.User;
import com.example.homework.repository.StatisticsRepo;
import com.example.homework.repository.UserRepo;
import com.example.homework.security.UserDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class CanvasjsChartService {


    @Autowired
    private UserRepo userRepo;

    @Autowired
    private StatisticsRepo statisticsRepo;

//    public void setCanvasjsChartDao(CanvasjsChartDao canvasjsChartDao) {
//        this.canvasjsChartDao = canvasjsChartDao;
//    }


    public List<List<Map<Object, Object>>> getCanvasjsChartData(String country) {
        UserDetail userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String name = userDetail.getUsername();
        System.out.println("UserName : " + name);
        Optional<User> user = userRepo.findByName(name);
        Statictics stats = null;
        if (user.isPresent()) {
            if (country == null) {
                Optional<Statictics> opt = statisticsRepo.findFirstByUser_Id(user.get().getId());
                if (opt.isPresent())
                    stats = opt.get();
            } else {
                Optional<Statictics> opt = statisticsRepo.findByCountryNameAndUser_id(country, user.get().getId());
                if (opt.isPresent())
                    stats = opt.get();
            }
            Map<Object, Object> map = null;
            List<List<Map<Object, Object>>> list = new ArrayList<List<Map<Object, Object>>>();
            List<Map<Object, Object>> dataPoints1 = new ArrayList<Map<Object, Object>>();
            map = new HashMap<Object, Object>();
            map.put("label", "New Cases");
            map.put("y", stats.getNewCases());
            dataPoints1.add(map);
            map = new HashMap<Object, Object>();
            map.put("label", "Total Cases");
            map.put("y", stats.getTotalCases());
            dataPoints1.add(map);
            map = new HashMap<Object, Object>();
            map.put("label", "Total Deaths");
            map.put("y", stats.getTotalDeaths());
            dataPoints1.add(map);
//                map = new HashMap<Object,Object>(); map.put("label", "Entertainment & Fun"); map.put("y", 20);dataPoints1.add(map);
//                map = new HashMap<Object,Object>(); map.put("label", "Savings"); map.put("y", 10);dataPoints1.add(map);
//                map = new HashMap<Object,Object>(); map.put("label", "Cellphone & Internet"); map.put("y", 10);dataPoints1.add(map);

            list.add(dataPoints1);

            return list;
        } else
            return null;

    }

    public List<String> getAllSavedCoutriesNames() {
        UserDetail userDetail = (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String name = userDetail.getUsername();
        System.out.println("UserName : " + name);
        Optional<User> user = userRepo.findByName(name);
        if (user.isPresent()) {
            return statisticsRepo.findAllCountryNames(user.get().getId());

        }
        return null;
    }

}
