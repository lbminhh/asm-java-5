package com.poly.demo.controller;

import com.poly.demo.entity.ProductDetail;
import com.poly.demo.entity.User;
import com.poly.demo.model.request.ProductDetailRequest;
import com.poly.demo.model.response.ProductDetailResponse;
import com.poly.demo.model.response.ProductResponse;
import com.poly.demo.repository.ProductDetailRepository;
import com.poly.demo.service.ColorService;
import com.poly.demo.service.ProductDetailService;
import com.poly.demo.service.ProductService;
import com.poly.demo.service.SizeService;
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
@RequestMapping("/product-detail")
public class ProductDetailController {

    @Autowired
    private ProductDetailService productDetailService;

    @Autowired
    private ProductService productService;

    @Autowired
    private ColorService colorService;

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

    @GetMapping("/index")
    public String getAll(Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
//        Page<ProductDetailResponse> data = productDetailService.getAll(null, page);
        //List product
        model.addAttribute("listProducts", productService.getAllProducts());
        //List product detail by page
        model.addAttribute("listProductDetail", null);
        model.addAttribute("listColors", colorService.getAll());
        model.addAttribute("listSizes", sizeService.getAll());
//        model.addAttribute("currentPage", data.getPageable().getPageNumber() + 1);
//        model.addAttribute("totalPages", data.getTotalPages());
//        model.addAttribute("isSearch", false);
        return "product-detail/list";

    }

    @GetMapping("/list")
    public String getAll(@RequestParam int page,
                         @RequestParam(required = false, defaultValue = "") Long productID,
                         @RequestParam(required = false, defaultValue = "") Long colorID,
                         @RequestParam(required = false, defaultValue = "") Long sizeID,
                         Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }


        Page<ProductDetailResponse> data = productDetailService.getAll(productID, page, colorID, sizeID);
        //List product
        model.addAttribute("listProducts", productService.getAllProducts());
        //List product detail by page
        model.addAttribute("listProductDetail", data.getContent());
        //Lấy ra page hiện tại
        model.addAttribute("currentPage", data.getPageable().getPageNumber() + 1);
        //Lấy ra tổng số page
        model.addAttribute("totalPages", data.getTotalPages());
        //List color
        model.addAttribute("listColors", colorService.getAll());
        //List size
        model.addAttribute("listSizes", sizeService.getAll());
        //Lấy giá trị search
        model.addAttribute("productID", productID);
        model.addAttribute("sizeID", sizeID);
        model.addAttribute("colorID", colorID);

        return "product-detail/list";

    }

    @GetMapping("/create")
    public String add(@RequestParam Long productID, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }
        //List color
        model.addAttribute("listColors", colorService.getAll());
        //List size
        model.addAttribute("listSizes", sizeService.getAll());
        //Product
        model.addAttribute("product", productService.getProductById(productID));

        return "product-detail/add";
    }

    @PostMapping("/store")
    public String store(Model model,
                        @Valid ProductDetailRequest request,
                        BindingResult result,
                        RedirectAttributes redirectAttributes) {
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
            //List color
            model.addAttribute("listColors", colorService.getAll());
            //List size
            model.addAttribute("listSizes", sizeService.getAll());
            model.addAttribute("product", productService.getProductById(request.getProductID()));
            model.addAttribute("errors", errors);
            return "product-detail/add";
        }
        System.out.println(productDetailService.add(request));
        redirectAttributes.addFlashAttribute("successMessage", "Sản phẩm đã được thêm thành công!");
        return "redirect:/product-detail/list?page=1&productID=" + request.getProductID();
    }


    @GetMapping("/edit/{id}")
    public String edit(@PathVariable Long id, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (getRole().equalsIgnoreCase("user")) {
            model.addAttribute("errorMessage", "Bạn không đủ quyền hạn cần thiết");
            return "error-page";
        }

        ProductDetail productDetail = productDetailService.getProductDetailById(id);
        ProductDetailRequest request = ProductDetailRequest.builder()
                .price(productDetail.getPrice())
                .productID(productDetail.getProduct().getId())
                .colorID(productDetail.getColor().getId())
                .quantity(productDetail.getQuanity())
                .status(productDetail.getStatus())
                .sizeID(productDetail.getSize().getId())
                .build();
        model.addAttribute("id", id);
        model.addAttribute("request", request);
        model.addAttribute("product", productService.getProductById(request.getProductID()));
        //List color
        model.addAttribute("listColors", colorService.getAll());
        //List size
        model.addAttribute("listSizes", sizeService.getAll());
        model.addAttribute("item", productDetailService.getProductDetailById(id));
        return "product-detail/edit";
    }

    @PostMapping("/update/{id}")
    public String update(@PathVariable Long id,
                         Model model,
                         @Valid ProductDetailRequest request,
                         BindingResult result,
                         RedirectAttributes redirectAttributes) {
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
            model.addAttribute("id", id);
            model.addAttribute("product", productService.getProductById(request.getProductID()));
            //List color
            model.addAttribute("listColors", colorService.getAll());
            //List size
            model.addAttribute("listSizes", sizeService.getAll());
            model.addAttribute("product", productService.getProductById(request.getProductID()));
            model.addAttribute("errors", errors);
            return "product-detail/edit";
        }
        System.out.println(productDetailService.update(request, id));
        redirectAttributes.addFlashAttribute("successMessage", "Sản phẩm đã được sửa thành công!");
        return "redirect:/product-detail/edit/" + id;
    }

}
