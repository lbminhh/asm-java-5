package com.poly.demo.service;

import com.poly.demo.model.request.OrderDetailRequest;
import com.poly.demo.model.response.OrderDetailResponse;
import com.poly.demo.model.response.ProductCardResponse;

import java.util.List;
import java.util.UUID;

public interface OrderDetailService {

    String add(OrderDetailRequest orderDetailRequest);

    List<OrderDetailResponse> getAllProductCardByOrderID(UUID orderID);

    String delete(String id);

    String update(OrderDetailRequest orderDetailRequest, String id);
}
