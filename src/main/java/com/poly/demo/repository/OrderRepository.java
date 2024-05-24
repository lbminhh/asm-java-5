package com.poly.demo.repository;

import com.poly.demo.entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface OrderRepository extends JpaRepository<Order, UUID> {

    @Modifying
    @Query("UPDATE Order o SET o.totalMoney = :totalMoney, o.quantity = :quantity " +
            "WHERE  o.id = :id")
    void updateOrder(Double totalMoney, Integer quantity, UUID id);

    @Query("SELECT o FROM Order o ORDER BY o.timeCreate DESC ")
    Page<Order> getAllByPage(Pageable pageable);

}
