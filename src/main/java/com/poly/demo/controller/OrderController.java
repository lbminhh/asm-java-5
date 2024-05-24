package com.poly.demo.controller;

import com.poly.demo.entity.Order;
import com.poly.demo.entity.User;
import com.poly.demo.model.request.CustomerRequest;
import com.poly.demo.model.request.OrderRequest;
import com.poly.demo.model.response.ProductCardResponse;
import com.poly.demo.model.response.ProductResponse;
import com.poly.demo.service.BrandService;
import com.poly.demo.service.ColorService;
import com.poly.demo.service.CustomerService;
import com.poly.demo.service.OrderDetailService;
import com.poly.demo.service.OrderService;
import com.poly.demo.service.ProductDetailService;
import com.poly.demo.service.SizeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private ProductDetailService productDetailService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    private ColorService colorService;

    @Autowired
    private SizeService sizeService;

    @Autowired
    private BrandService brandService;

    @Autowired
    private CustomerService customerService;

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
    public String getIndex(Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        model.addAttribute("userid", "674A77CE-8DCA-48C8-99B0-36CBA10E1E7B");
        return "sales-counter/index";
    }

    @GetMapping("/detail")
    public String getDetail(Model model,
                            @RequestParam String id,
                            RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        Order order = orderService.findById(id);
        if (order.getStatus() != null) {
            if (!order.getStatus()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng thử lại sau!");
                return "redirect:/order/index";
            }
        }
        model.addAttribute("order", order);
        model.addAttribute("customer", order.getCustomer());
        model.addAttribute("user", order.getUser());
        model.addAttribute("listCustomers", customerService.getAll());
        model.addAttribute("listProductCard", productDetailService.getAllProductCard());
        model.addAttribute("listOrderDetails", orderDetailService.getAllProductCardByOrderID(UUID.fromString(id)));
        return "sales-counter/index";
    }

    @GetMapping("/product-order")
    public ResponseEntity<List<ProductCardResponse>> getProductCard() {
        return new ResponseEntity<>(productDetailService.getAllProductCard(), HttpStatus.OK);
    }

    @PostMapping("/create")
    public String create( OrderRequest orderRequest,
                          RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        UUID id = orderService.add(orderRequest);
        System.out.println(id);
        System.out.println(orderRequest);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm hoá đơn thành công");
        return "redirect:/order/detail?id=" + id;
    }

    @GetMapping("/delete/{id}")
    public String create(@PathVariable String id,
                         RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        orderService.delete(id);
        redirectAttributes.addFlashAttribute("successMessage", "Xoá thành công");
        return "redirect:/order/index";
    }

    @PostMapping("/update-customer/{id}")
    public String updateCustomer( CustomerRequest customerRequest,
                          @PathVariable String id,
                          RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        orderService.updateCustomer(customerRequest, UUID.fromString(id));
        redirectAttributes.addFlashAttribute("successMessage", "Đã cập nhật hoá đơn!");
        return "redirect:/order/detail?id=" + id;
    }

    @PostMapping("/comlete/{id}")
    public String comlete(@RequestBody OrderRequest orderRequest,
                                  @PathVariable String id,
                                  RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        orderService.update(orderRequest, UUID.fromString(id));
        redirectAttributes.addFlashAttribute("successMessage", "Hoá đơn đã được hoàn thành!");
        return "redirect:/order/index";
    }


    @GetMapping("/list")
    public String list(@RequestParam int page, Model model) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        Page<Order> data = orderService.getAll(page);
        model.addAttribute("list", data.getContent());
        model.addAttribute("currentPage", data.getPageable().getPageNumber() + 1);
        model.addAttribute("totalPages", data.getTotalPages());
        
        return "order/list";
    }

    @GetMapping("/detail/{id}")
    public String detail(Model model,
                            @PathVariable String id,
                            RedirectAttributes redirectAttributes) {
        if (!isLogin()) {
            return "redirect:/view-login";
        }
        Order order = orderService.findById(id);
        model.addAttribute("order", order);
        model.addAttribute("customer", order.getCustomer());
        model.addAttribute("user", order.getUser());
        model.addAttribute("listOrderDetails", orderDetailService.getAllProductCardByOrderID(UUID.fromString(id)));
        return "order/index";
    }
}
