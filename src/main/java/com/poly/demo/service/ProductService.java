package com.poly.demo.service;

import com.poly.demo.entity.Product;
import com.poly.demo.model.request.ProductRequest;
import com.poly.demo.model.response.ProductResponse;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ProductService {

    Page<ProductResponse> getProductPagination(int page);

    String addProduct(ProductRequest productRequest);

    String updateProduct(ProductRequest request, Long id);

    Page<ProductResponse> searchProduct(int page, String productName);

    Product getProductById(Long id);

    List<ProductResponse> getAllProducts();
}
