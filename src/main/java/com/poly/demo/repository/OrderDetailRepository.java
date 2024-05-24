package com.poly.demo.repository;

import com.poly.demo.entity.Order;
import com.poly.demo.entity.OrderDetail;
import com.poly.demo.entity.ProductDetail;
import com.poly.demo.model.response.OrderDetailResponse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, UUID> {

    @Query("SELECT new com.poly.demo.model.response.OrderDetailResponse(" +
            "od.id, pd.id, p.productName, c.colorName, s.sizeName, od.quantity, od.totalMoney) " +
            "FROM ProductDetail pd JOIN Product p ON p.id = pd.product.id " +
            "JOIN Color c ON c.id = pd.color.id JOIN Size s ON s.id = pd.size.id " +
            "JOIN OrderDetail od ON od.productDetail.id = pd.id " +
            "WHERE od.order.id = :orderID")
    List<OrderDetailResponse> getAllProductCardByOrderID(UUID orderID);

    void deleteAllByOrder(Order order);

    Optional<OrderDetail> findByOrOrderAndProductDetail(Order order, ProductDetail productDetail);

    List<OrderDetail> findAllByOrOrder(Order order);



}
