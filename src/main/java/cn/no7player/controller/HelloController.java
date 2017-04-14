package cn.no7player.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HelloController {

    @RequestMapping("/hello")
    public String greeting(@RequestParam(value="name", required=false, defaultValue="World") String name, Model model) {
        model.addAttribute("name", name);
        return "hello";
    }
    @RequestMapping("/hello2")
    public String greeting2(@RequestParam(value="name", required=false, defaultValue="World") String name, Model model) {
        model.addAttribute("name", name);
        return "index";
    }
    
    @RequestMapping(value="/")

    public ModelAndView example(HttpServletRequest request) {

    return new ModelAndView("index");

    }
    
    
    @RequestMapping(value="/login")

    public ModelAndView login(HttpServletRequest request) {

    return new ModelAndView("login");

    }
    
    
    @RequestMapping(value="/employee/list")

    public ModelAndView employee(HttpServletRequest request) {

    return new ModelAndView("employee/list");
    }
    @RequestMapping(value="/employee/form")

    public ModelAndView employeeform(HttpServletRequest request) {

    return new ModelAndView("employee/form");

    }
    
    @RequestMapping(value="/claimProduct/claimInvestPlanA/proList")

    public ModelAndView claimProduct(HttpServletRequest request) {

    return new ModelAndView("/claim/claimProduct/list-claimProduct");

    }
    @RequestMapping(value=" reward/createreward")

    public ModelAndView reward(HttpServletRequest request) {

    return new ModelAndView("reward/giftrecord");

    }
   
}
