package com.poly.demo.repository;

import com.poly.demo.entity.ProductDetail;
import com.poly.demo.model.response.ProductCardResponse;
import com.poly.demo.model.response.ProductDetailResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductDetailRepository extends JpaRepository<ProductDetail, Long> {

    @Query("SELECT new com.poly.demo.model.response.ProductDetailResponse(" +
            "pd.id, p.productName, pd.price, c.colorName, s.sizeName, pd.quanity, pd.status) " +
            "FROM ProductDetail pd JOIN Product p ON p.id = pd.product.id " +
            "JOIN Color c ON c.id = pd.color.id JOIN Size s ON s.id = pd.size.id " +
            "WHERE p.id = :productID " +
            "AND (c.id = :colorID OR :colorID IS NULL ) " +
            "AND (s.id = :sizeID OR :sizeID IS NULL )")
    Page<ProductDetailResponse> getAll(Pageable pageable , Long productID, Long colorID, Long sizeID);

    @Query("SELECT new com.poly.demo.model.response.ProductCardResponse(" +
            "pd.id, p.productName, pd.price, c.colorName, b.brandName, cg.categoryName, s.sizeName, pd.quanity) " +
            "FROM ProductDetail pd JOIN Product p ON p.id = pd.product.id " +
            "JOIN Color c ON c.id = pd.color.id JOIN Size s ON s.id = pd.size.id " +
            "JOIN Category cg ON cg.id = p.category.id JOIN Brand b ON b.id = p.brand.id " +
            "WHERE pd.status = true ")
    List<ProductCardResponse> getAllProductCard();



}
