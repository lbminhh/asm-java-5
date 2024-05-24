package com.poly.demo.service.impl;

import com.poly.demo.entity.Color;
import com.poly.demo.entity.Product;
import com.poly.demo.entity.ProductDetail;
import com.poly.demo.entity.Size;
import com.poly.demo.model.request.ProductDetailRequest;
import com.poly.demo.model.response.ProductCardResponse;
import com.poly.demo.model.response.ProductDetailResponse;
import com.poly.demo.repository.ColorRepository;
import com.poly.demo.repository.ProductDetailRepository;
import com.poly.demo.repository.ProductRepository;
import com.poly.demo.repository.SizeRepository;
import com.poly.demo.service.ProductDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class ProductDetailServiceImpl implements ProductDetailService {

    @Autowired
    private ProductDetailRepository productDetailRepository;

    @Autowired
    private ColorRepository colorRepository;

    @Autowired
    private SizeRepository sizeRepository;

    @Autowired
    private ProductRepository productRepository;

    @Override
    public Page<ProductDetailResponse> getAll(Long productID, int page, Long colorID, Long sizeID) {
        Pageable pageable = PageRequest.of(page - 1, 5);
        return productDetailRepository.getAll(pageable, productID, colorID, sizeID);
    }

    @Override
    public String add(ProductDetailRequest request) {

        Color color = colorRepository.findById(request.getColorID()).get();
        Product product = productRepository.findById(request.getProductID()).get();
        Size size = sizeRepository.findById(request.getSizeID()).get();

        productDetailRepository.save(ProductDetail.builder()
                .color(color)
                .id(null)
                .product(product)
                .price(request.getPrice())
                .quanity(request.getQuantity())
                .size(size)
                .status(request.getStatus())
                .build());

        return "Thêm thành công";
    }

    @Override
    public String update(ProductDetailRequest request, Long id) {
        Color color = colorRepository.findById(request.getColorID()).get();
        Product product = productRepository.findById(request.getProductID()).get();
        Size size = sizeRepository.findById(request.getSizeID()).get();

        productDetailRepository.save(ProductDetail.builder()
                .color(color)
                .id(id)
                .product(product)
                .price(request.getPrice())
                .quanity(request.getQuantity())
                .size(size)
                .status(request.getStatus())
                .build());

        return "Sửa thành công";
    }

    @Override
    public String delete(Long id) {
        productDetailRepository.deleteById(id);
        return null;
    }

    @Override
    public ProductDetail getProductDetailById(Long id) {
        return productDetailRepository.findById(id).get();
    }

    @Override
    public List<ProductCardResponse> getAllProductCard() {
        return productDetailRepository.getAllProductCard();
    }

    @Override
    public void updateQuantityProductDetail(Long id, Integer quantity, String method) {
        ProductDetail productDetail = productDetailRepository.findById(id).get();
        if (method.equalsIgnoreCase("minus")) {
            productDetail.setQuanity(productDetail.getQuanity() - quantity);
        } else {
            productDetail.setQuanity(productDetail.getQuanity() + quantity);
        }
        productDetailRepository.save(productDetail);
    }

    @Override
    public boolean existById(Long id) {
        return productDetailRepository.existsById(id);
    }


}
