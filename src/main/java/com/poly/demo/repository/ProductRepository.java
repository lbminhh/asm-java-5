package com.poly.demo.repository;

import com.poly.demo.entity.Product;
import com.poly.demo.model.response.ProductResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    @Query(value = "SELECT new com.poly.demo.model.response.ProductResponse(" +
            "p.id, p.productCode, p.productName, p.status, SUM(pd.quanity))" +
            "FROM Product p LEFT JOIN ProductDetail pd ON p.id = pd.product.id " +
            "GROUP BY p.id, p.productCode, p.productName, p.status " +
            "ORDER BY p.id DESC "
    )
    Page<ProductResponse> getProductByPage(Pageable pageable);

    @Query(value = "SELECT new com.poly.demo.model.response.ProductResponse(" +
            "p.id, p.productCode, p.productName, p.status, SUM(pd.quanity))" +
            "FROM Product p LEFT JOIN ProductDetail pd ON p.id = pd.product.id " +
            "GROUP BY p.id, p.productCode, p.productName, p.status " +
            "HAVING p.productName LIKE %:productName% OR :productName IS NULL " +
            "ORDER BY p.id DESC "
    )
    Page<ProductResponse> searchProductByPage(Pageable pageable, @Param("productName") String name);

}
