package com.poly.demo.service.impl;

import com.poly.demo.entity.Order;
import com.poly.demo.entity.OrderDetail;
import com.poly.demo.entity.ProductDetail;
import com.poly.demo.model.request.OrderDetailRequest;
import com.poly.demo.model.response.OrderDetailResponse;
import com.poly.demo.repository.OrderDetailRepository;
import com.poly.demo.repository.OrderRepository;
import com.poly.demo.repository.ProductDetailRepository;
import com.poly.demo.service.OrderDetailService;
import com.poly.demo.service.ProductDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class OrderDetailServiceImpl implements OrderDetailService {

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ProductDetailRepository productDetailRepository;

    @Autowired
    private ProductDetailService productDetailService;

    @Transactional
    @Override
    public String add(OrderDetailRequest orderDetailRequest) {
        ProductDetail productDetail = productDetailRepository.findById(orderDetailRequest.getProductDetailID()).get();
        Order order = orderRepository.findById(UUID.fromString(orderDetailRequest.getOrderID())).get();
        System.out.println(orderDetailRequest);
        Optional<OrderDetail> orderDetail = orderDetailRepository.findByOrOrderAndProductDetail(order, productDetail);

        if (orderDetail.isEmpty()) {
            if (orderDetailRequest.getQuantity() > productDetail.getQuanity()) {
                return "Quá số lượng";
            }
            OrderDetail orderDetail1 = orderDetailRepository.save(OrderDetail.builder()
                    .id(null)
                    .order(order)
                    .productDetail(productDetail)
                    .quantity(orderDetailRequest.getQuantity())
                    .totalMoney(productDetail.getPrice() * orderDetailRequest.getQuantity())
                    .build());
            updateOrder(order.getId());
            productDetailService.updateQuantityProductDetail(productDetail.getId(), orderDetail1.getQuantity(), "minus");
        } else {
            Integer totalQuantity = orderDetail.get().getQuantity() + orderDetailRequest.getQuantity();
            Double totalMoney = orderDetail.get().getTotalMoney() + (orderDetailRequest.getQuantity() * productDetail.getPrice());
            if (orderDetailRequest.getQuantity() > totalQuantity) {
                return "Quá số lượng";
            }
            OrderDetail orderDetail1 = orderDetailRepository.save(OrderDetail.builder()
                    .id(orderDetail.get().getId())
                    .order(order)
                    .productDetail(productDetail)
                    .quantity(totalQuantity)
                    .totalMoney(totalMoney)
                    .build());
            updateOrder(order.getId());
            productDetailService.updateQuantityProductDetail(productDetail.getId(), orderDetail1.getQuantity(), "minus");
        }
        return "Thêm thành công";
    }

    @Override
    public List<OrderDetailResponse> getAllProductCardByOrderID(UUID orderID) {
        return orderDetailRepository.getAllProductCardByOrderID(orderID);
    }

    @Transactional
    @Override
    public String delete(String id) {
        OrderDetail orderDetail = orderDetailRepository.findById(UUID.fromString(id)).get();
        orderDetailRepository.deleteById(UUID.fromString(id));
        updateOrder(orderDetail.getOrder().getId());
        productDetailService.updateQuantityProductDetail(orderDetail.getProductDetail().getId(), orderDetail.getQuantity(), "plus");
        return String.valueOf(orderDetail.getOrder().getId());
    }

    private void updateOrder(UUID id) {
        Double totalMoney = 0.0;
        Integer totalQuantity = 0;
        Order order = orderRepository.findById(id).get();
        List<OrderDetailResponse> listOrderDetails = getAllProductCardByOrderID(id);
        for (OrderDetailResponse item : listOrderDetails) {
            totalMoney += item.getTotalMoney();
            totalQuantity += item.getQuantity();
        }
        orderRepository.updateOrder(totalMoney, totalQuantity, id);
    }



    @Transactional
    @Override
    public String update(OrderDetailRequest orderDetailRequest, String id) {
        ProductDetail productDetail = productDetailRepository.findById(orderDetailRequest.getProductDetailID()).get();
        Order order = orderRepository.findById(UUID.fromString(orderDetailRequest.getOrderID())).get();
        OrderDetail orderDetail = orderDetailRepository.findById(UUID.fromString(id)).get();

        Integer totalQuantity;

        if (orderDetailRequest.getMethod().equalsIgnoreCase("plus")) {
            if (orderDetailRequest.getQuantity() > productDetail.getQuanity()) {
                return "Quá số lượng";
            }
            totalQuantity = orderDetail.getQuantity() + orderDetailRequest.getQuantity();
        } else {
            totalQuantity = orderDetail.getQuantity() - orderDetailRequest.getQuantity();
        }

        orderDetail.setQuantity(totalQuantity);
        orderDetail.setTotalMoney(productDetail.getPrice() * totalQuantity);
        orderDetailRepository.save(orderDetail);

        updateOrder(order.getId());
        if (orderDetailRequest.getMethod().equalsIgnoreCase("minus")) {
            productDetailService.updateQuantityProductDetail(productDetail.getId(), 1, "plus");
        } else {
            productDetailService.updateQuantityProductDetail(productDetail.getId(), 1, "minus");
        }
        return "Sửa thành công";
    }
}
