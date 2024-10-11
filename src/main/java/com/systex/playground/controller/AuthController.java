package com.systex.playground.controller;

import com.systex.playground.model.Member;
import com.systex.playground.service.UserService;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/index")
    public String showIndexPage() {
        return "index";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); 
        return "redirect:/login"; 
    }

    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }
    
    @PostMapping("/login")
    public String LoginPage() {
        return "login";
    }

    @PostMapping("/ajaxlogin")
    public String AjaxLoginPage() {
        return "ajaxlogin";
    }

    @GetMapping("/ajaxlogin")
    public String showAjaxLoginPage() {
        return "ajaxlogin";
    }

    @GetMapping("/register")
    public ModelAndView register() {
        return new ModelAndView("register", "command", new Member());
    }

    @PostMapping("/register")
    public String register(@ModelAttribute Member member, 
                           @RequestParam("confirmPassword") String confirmPassword,
                           Model model, 
                           RedirectAttributes redirectAttributes) {
        // 密碼不匹配
        if (!member.getPassword().equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match.");
            return "register";
        }

        // 帳號已存在
        if (userService.isUsernameTaken(member.getUsername())) {
            model.addAttribute("error", "Username already exists.");
            return "register";
        }

        userService.registerNewUser(member);
        redirectAttributes.addFlashAttribute("success", "Registration successful! Please log in.");
        return "redirect:/login";
    }
}
