package com.poly.demo.controller;

import com.poly.demo.entity.Color;
import com.poly.demo.entity.User;
import com.poly.demo.model.request.ColorRequest;
import com.poly.demo.model.response.ProductDetailResponse;
import com.poly.demo.service.ColorService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("color")
public class ColorController {

    @Autowired
    private ColorService colorService;

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
    public String getAll(@RequestParam int page, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        Page<Color> data = colorService.getAllByPage(page);
        //List product detail by page
        model.addAttribute("listColors", data.getContent());
        //Lấy ra page hiện tại
        model.addAttribute("currentPage", data.getPageable().getPageNumber() + 1);
        //Lấy ra tổng số page
        model.addAttribute("totalPages", data.getTotalPages());
        System.out.println("Data: " + data.getContent());
        return "color/index";
    }

    @PostMapping("/store")
    public String add(ColorRequest request, RedirectAttributes redirectAttributes, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        if (request.getColorName().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng nhập màu sắc");
            return "redirect:/color/list?page=1";
        }
        colorService.add(request);
        redirectAttributes.addFlashAttribute("successMessage", "Màu sắc đã được thêm thành công!");
        return "redirect:/color/list?page=1";
    }

    @PostMapping("/update/{id}")
    public String update(ColorRequest request, @PathVariable Long id, RedirectAttributes redirectAttributes, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        if (request.getColorName().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng nhập màu sắc");
            return "redirect:/color/list?page=1";
        }
        colorService.update(request, id);

        redirectAttributes.addFlashAttribute("successMessage", "Màu sắc đã sửa thêm thành công!");
        return "redirect:/color/list?page=1";
    }

}
