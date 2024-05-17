package com.poly.demo.service;

import com.poly.demo.model.request.ProductRequest;
import com.poly.demo.model.response.ProductResponse;
import org.springframework.data.domain.Page;

public interface ProductService {

    Page<ProductResponse> getProductPagination(int page);

    String addProduct(ProductRequest productRequest);

    String updateProduct(ProductRequest request, Long id);

    Page<ProductResponse> searchProduct(int page, String productName);
}
