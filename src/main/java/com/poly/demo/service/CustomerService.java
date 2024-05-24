package com.poly.demo.service;

import com.poly.demo.entity.Customer;
import com.poly.demo.model.request.CustomerRequest;
import org.springframework.data.domain.Page;

import java.util.List;

public interface CustomerService {

    List<Customer> getAll();

    Page<Customer> getAllByPage(int page);

    Customer getCustomerById(Long id);

    String update(CustomerRequest request, Long id);
}
