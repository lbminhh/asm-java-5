package com.poly.demo.controller;

import com.poly.demo.entity.Size;
import com.poly.demo.entity.User;
import com.poly.demo.model.request.SizeRequest;
import com.poly.demo.service.SizeService;
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
@RequestMapping("size")
public class SizeController {

    @Autowired
    private SizeService sizeService;

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
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        Page<Size> data = sizeService.getAllByPage(page);
        //List product detail by page
        model.addAttribute("listSizes", data.getContent());
        //Lấy ra page hiện tại
        model.addAttribute("currentPage", data.getPageable().getPageNumber() + 1);
        //Lấy ra tổng số page
        model.addAttribute("totalPages", data.getTotalPages());
        System.out.println("Data: " + data.getContent());
        return "size/index";
    }

    @PostMapping("/store")
    public String add(SizeRequest request, RedirectAttributes redirectAttributes, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        if (request.getSizeName().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng nhập kích cỡ");
            return "redirect:/size/list?page=1";
        }
        sizeService.add(request);
        redirectAttributes.addFlashAttribute("successMessage", "Kích cỡ đã được thêm thành công!");
        return "redirect:/size/list?page=1";
    }

    @PostMapping("/update/{id}")
    public String update(SizeRequest request, @PathVariable Long id, RedirectAttributes redirectAttributes, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        if (request.getSizeName().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng nhập kích cỡ");
            return "redirect:/size/list?page=1";
        }
        sizeService.update(request, id);

        redirectAttributes.addFlashAttribute("successMessage", "Kích cỡ đã sửa thêm thành công!");
        return "redirect:/size/list?page=1";
    }

}
