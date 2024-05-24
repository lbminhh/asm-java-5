package com.poly.demo.service.impl;

import com.poly.demo.entity.Customer;
import com.poly.demo.model.request.CustomerRequest;
import com.poly.demo.repository.CustomerRepository;
import com.poly.demo.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerRepository customerRepository;

    @Override
    public List<Customer> getAll() {
        return customerRepository.findAll();
    }

    @Override
    public Page<Customer> getAllByPage(int page) {
        Pageable pageable = PageRequest.of(page - 1, 7);
        return customerRepository.getAllByPage(pageable);
    }

    @Override
    public Customer getCustomerById(Long id) {
        return customerRepository.findById(id).get();
    }

    @Override
    public String update(CustomerRequest request, Long id) {
        customerRepository.save(Customer.builder()
                .id(id)
                .fullName(request.getFullName())
                .phoneNumber(request.getPhoneNumber())
                .address(request.getAddress())
                .build());
        return null;
    }
}
