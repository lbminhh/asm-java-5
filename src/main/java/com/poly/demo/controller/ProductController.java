package com.poly.demo.controller;

import com.poly.demo.entity.User;
import com.poly.demo.model.request.ProductRequest;
import com.poly.demo.model.response.ProductResponse;
import com.poly.demo.service.BrandService;
import com.poly.demo.service.CategoryService;
import com.poly.demo.service.ProductService;
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

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private BrandService brandService;

    @Autowired
    private CategoryService categoryService;

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
        Page<ProductResponse> data = productService.getProductPagination(page);
        model.addAttribute("list", data.getContent());
        model.addAttribute("currentPage", data.getPageable().getPageNumber() + 1);
        model.addAttribute("totalPages", data.getTotalPages());
        model.addAttribute("isSearch", false);
        return "product/list";
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
        model.addAttribute("listBrands", brandService.getAll());
        model.addAttribute("listCategories", categoryService.getAll());
        return "product/add";
    }

    @PostMapping("/store")
    public String add(Model model, @Valid ProductRequest request, BindingResult result, RedirectAttributes redirectAttributes) {
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
            model.addAttribute("listBrands", brandService.getAll());
            model.addAttribute("listCategories", categoryService.getAll());
            model.addAttribute("errors", errors);
            return "product/add";
        }
        productService.addProduct(request);
        redirectAttributes.addFlashAttribute("successMessage", "Sản phẩm đã được thêm thành công!");
        return "redirect:/product/list?page=1";
    }

    @GetMapping("/edit/{id}")
    public String edit(Model model, @PathVariable Long id) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        model.addAttribute("listBrands", brandService.getAll());
        model.addAttribute("listCategories", categoryService.getAll());
        model.addAttribute("product", productService.getProductById(id));
        return "product/edit";
    }

    @PostMapping("/update/{id}")
    public String update(@Valid  ProductRequest request, BindingResult result, Model model, @PathVariable Long id, RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        System.out.println(productService.updateProduct(request, id));
        redirectAttributes.addFlashAttribute("successMessage", "Sản phẩm đã được sửa thành công!");
        return "redirect:/product/edit/" + id;
    }

    @GetMapping("/search")
    public String search(@RequestParam String value, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        if (value.isEmpty()) {
            return "redirect:/product/list?page=1";
        }
        Page<ProductResponse> data = productService.searchProduct(1, value);
        System.out.println("Data" + data.getContent());
        model.addAttribute("list", data.getContent());
        model.addAttribute("currentPage", Integer.valueOf(data.getPageable().getPageNumber() + 1));
        model.addAttribute("totalPages", data.getTotalPages());
        model.addAttribute("isSearch", true);
        model.addAttribute("valueSearch", value);
        System.out.println("Page" + data.getPageable().getPageNumber() + 1);
        System.out.println("Total Pages: " + data.getTotalPages());
        return "product/list";
    }

    @GetMapping("/list/search")
    public String searchByPage(@RequestParam String value, @RequestParam int page, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        Page<ProductResponse> data = productService.searchProduct(page, value);
        model.addAttribute("list", data.getContent());
        model.addAttribute("currentPage", data.getPageable().getPageNumber() + 1);
        model.addAttribute("totalPages", data.getTotalPages());
        model.addAttribute("isSearch", true);
        model.addAttribute("valueSearch", value);
        return "product/list";
    }

}
