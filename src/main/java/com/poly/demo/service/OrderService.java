package com.poly.demo.service;

import com.poly.demo.entity.Order;
import com.poly.demo.model.request.CustomerRequest;
import com.poly.demo.model.request.OrderRequest;
import org.springframework.data.domain.Page;

import java.util.List;
import java.util.UUID;

public interface OrderService {

    UUID add(OrderRequest orderRequest);

    Order findById(String id);

    String delete(String id);

    String update(OrderRequest request, UUID id);

    String updateCustomer(CustomerRequest request, UUID id);

    Page<Order> getAll(int page);
}
