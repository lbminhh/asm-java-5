package com.poly.demo.controller;

import com.poly.demo.entity.User;
import com.poly.demo.model.request.ProductRequest;
import com.poly.demo.model.request.UserRequest;
import com.poly.demo.model.response.ProductResponse;
import com.poly.demo.service.BrandService;
import com.poly.demo.service.CategoryService;
import com.poly.demo.service.ProductService;
import com.poly.demo.service.UserService;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private HttpSession session;

    private Boolean isLogin() {
        User user = (User) session.getAttribute("user");
        return user != null;
    }

    private String getRole() {
        User user = (User) session.getAttribute("user");
        return user.getRoleName();
    }

    @GetMapping("/list")
    public String getAll(@RequestParam("page") int page, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        Page<User> data = userService.getAll(page);
        model.addAttribute("list", data.getContent());
        model.addAttribute("currentPage", data.getPageable().getPageNumber() + 1);
        model.addAttribute("totalPages", data.getTotalPages());
        return "user/list";
    }

    @GetMapping("/create")
    public String create(Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        return "user/add";
    }

    @PostMapping("/store")
    public String add(Model model, @Valid UserRequest request, BindingResult result, RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }


        if (result.hasErrors()) {

            Map<String, String> errors = new HashMap<>();
            for (FieldError e : result.getFieldErrors()) {
                errors.put(e.getField(), e.getDefaultMessage());
            }
            model.addAttribute("request", request);
            model.addAttribute("errors", errors);
            return "user/add";
        }
        userService.add(request);
        redirectAttributes.addFlashAttribute("successMessage", "Người dùng đã được thêm thành công!");
        return "redirect:/user/list?page=1";
    }

    @GetMapping("/edit/{id}")
    public String edit(Model model, @PathVariable UUID id) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }

        model.addAttribute("user", userService.getUserById(id));
        return "user/edit";
    }

    @PostMapping("/update/{id}")
    public String update(@Valid  UserRequest request, BindingResult result, Model model, @PathVariable UUID id, RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }

        if (result.hasErrors()) {

            Map<String, String> errors = new HashMap<>();
            for (FieldError e : result.getFieldErrors()) {
                errors.put(e.getField(), e.getDefaultMessage());
            }
            model.addAttribute("product", request);
            model.addAttribute("errors", errors);
            return "user/edit";
        }
        System.out.println(userService.update(request, id));
        redirectAttributes.addFlashAttribute("successMessage", "Người dùng đã được sửa thành công!");
        return "redirect:/user/edit/" + id;
    }

}
