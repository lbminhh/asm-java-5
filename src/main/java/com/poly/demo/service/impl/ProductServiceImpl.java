package com.poly.demo.service.impl;

import com.poly.demo.entity.Product;
import com.poly.demo.model.request.ProductRequest;
import com.poly.demo.model.response.ProductResponse;
import com.poly.demo.repository.ProductRepository;
import com.poly.demo.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    ProductRepository productRepository;

    @Override
    public Page<ProductResponse> getProductPagination(int page) {
        Pageable pageable = PageRequest.of(page - 1, 5);
        return productRepository.getProductByPage(pageable);
    }

    @Override
    public String addProduct(ProductRequest request) {
        productRepository.save(Product.builder()
                .status(request.getStatus())
                .productCode(request.getProductCode())
                .productName(request.getProductName())
                .id(null)
                .build());
        return "add product successfully";
    }

    @Override
    public String updateProduct(ProductRequest request, Long id) {
        productRepository.save(Product.builder()
                .status(request.getStatus())
                .productCode(request.getProductCode())
                .productName(request.getProductName())
                .id(id)
                .build());
        return "Update product successfully";
    }

    @Override
    public Page<ProductResponse> searchProduct(int page, String productName) {
        Pageable pageable = PageRequest.of(page - 1, 5);
        return productRepository.searchProductByPage(pageable, productName);
    }
}
