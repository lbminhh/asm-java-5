package com.poly.demo.controller;

import com.poly.demo.entity.User;
import com.poly.demo.model.request.LoginRequest;
import com.poly.demo.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;


    @GetMapping("/view-login")
    public String viewLogin(HttpSession httpSession) {
        return "login";
    }

    @PostMapping("/login")
    public String login(LoginRequest request,
                        HttpSession httpSession,
                        Model model,
                        RedirectAttributes redirectAttributes) {
        System.out.println(request);
        User user = userService.findByUsernameAndPassword(request.getUsername(), request.getPassword());
        if (user == null) {
            model.addAttribute("error", "Tài khoản hoặc mật khẩu không chính xác!");
            model.addAttribute("request", request);
            return "login";
        } else {
            System.out.println("Success");
            httpSession.setAttribute("user", user);
            redirectAttributes.addFlashAttribute("successMessage", "Đã đăng nhập thành công!");
            return "redirect:/order/index";
        }
    }

    @GetMapping("/logout")
    public String home(HttpSession session) {
        session.removeAttribute("user");
        return "redirect:/view-login";
    }



}
