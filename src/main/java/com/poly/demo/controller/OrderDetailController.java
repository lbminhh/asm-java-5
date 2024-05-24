package com.poly.demo.controller;

import com.poly.demo.entity.User;
import com.poly.demo.model.request.OrderDetailRequest;
import com.poly.demo.service.OrderDetailService;
import com.poly.demo.service.ProductDetailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("order-detail")
public class OrderDetailController {

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    private HttpSession session;

    @Autowired
    private ProductDetailService productDetailService;

    private Boolean isLogin() {
        User user = (User) session.getAttribute("user");
        return user != null;
    }

    @PostMapping("/create")
    public String create(OrderDetailRequest request, RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (request.getQuantity() <= 0) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng thử lại, số lượng phải lớn 0!");
            return "redirect:/order/detail?id=" + request.getOrderID();
        }
        String result = orderDetailService.add(request);
        if (result.equalsIgnoreCase("Quá số lượng")) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng thử lại, sản phẩm trong kho không đủ!");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Đã thêm sản phẩm vào giỏ hàng!");
        }
        return "redirect:/order/detail?id=" + request.getOrderID();
    }

    @PostMapping("/qr-code")
    public String scanQrCode(@RequestBody OrderDetailRequest request, RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        if (!productDetailService.existById(request.getProductDetailID())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng thử lại, sản phẩm này không tồn tại!");
            return "redirect:/order/detail?id=" + request.getOrderID();
        }
        String result = orderDetailService.add(request);
        if (result.equalsIgnoreCase("Quá số lượng")) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng thử lại, sản phẩm trong kho không đủ!");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Đã thêm sản phẩm vào giỏ hàng!");
        }
        return "redirect:/order/detail?id=" + request.getOrderID();
    }

    @PostMapping("/update/{id}")
    public String plus(OrderDetailRequest request,
                       @PathVariable String id,
                       RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }

        String result = orderDetailService.update(request, id);
        if (result.equalsIgnoreCase("Quá số lượng")) {
            redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng thử lại, sản phẩm trong kho không đủ!");
        } else {
            redirectAttributes.addFlashAttribute("successMessage", "Đã sửa sản phẩm vào giỏ hàng!");
        }
        return "redirect:/order/detail?id=" + request.getOrderID();
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable String id, RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }

        String orderID = orderDetailService.delete(id);
        redirectAttributes.addFlashAttribute("successMessage", "Xoá thành công");
        return "redirect:/order/detail?id=" + orderID;
    }

}
