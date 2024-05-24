package com.poly.demo.service;

import com.poly.demo.entity.ProductDetail;
import com.poly.demo.model.request.ProductDetailRequest;
import com.poly.demo.model.response.ProductCardResponse;
import com.poly.demo.model.response.ProductDetailResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;


public interface ProductDetailService {

    Page<ProductDetailResponse> getAll(Long productID, int page, Long colorID, Long sizeID);

    String add(ProductDetailRequest request);

    String update(ProductDetailRequest request, Long id);

    String delete(Long id);

    ProductDetail getProductDetailById(Long id);

    List<ProductCardResponse> getAllProductCard();

    void updateQuantityProductDetail(Long id, Integer quantity, String method);

    boolean existById(Long id);


}
