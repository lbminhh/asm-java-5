package com.poly.demo.controller;

import com.poly.demo.model.request.ProductRequest;
import com.poly.demo.model.response.ProductResponse;
import com.poly.demo.service.ProductService;
import org.eclipse.tags.shaded.org.apache.xpath.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    ProductService productService;

    @GetMapping("/list")
    public String getAll(@RequestParam("page") int page, Model model) {
        Page<ProductResponse> data = productService.getProductPagination(page);
        model.addAttribute("list", data.getContent());
        model.addAttribute("currentPage", data.getPageable().getPageNumber() + 1);
        model.addAttribute("totalPages", data.getTotalPages());
        model.addAttribute("isSearch", false);
        return "product";
    }

    @PostMapping("/add")
    public String add(ProductRequest request) {
        System.out.println(request);
        System.out.println(productService.addProduct(request));
        return "redirect:/product/list?page=1";
    }

    @PostMapping("/update/{id}")
    public String update(ProductRequest request, @PathVariable Long id) {
        System.out.println(request);
        System.out.println(productService.updateProduct(request, id));
        return "redirect:/product/list?page=1";
    }

    @GetMapping("/search")
    public String search(@RequestParam String value, Model model) {
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
        return "product";
    }

    @GetMapping("/list/search")
    public String searchByPage(@RequestParam String value, @RequestParam int page, Model model) {
        Page<ProductResponse> data = productService.searchProduct(page, value);
        model.addAttribute("list", data.getContent());
        model.addAttribute("currentPage", data.getPageable().getPageNumber() + 1);
        model.addAttribute("totalPages", data.getTotalPages());
        model.addAttribute("isSearch", true);
        model.addAttribute("valueSearch", value);
        return "product";
    }

}
