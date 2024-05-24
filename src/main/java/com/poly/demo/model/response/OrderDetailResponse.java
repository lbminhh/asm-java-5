package com.poly.demo.model.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailResponse {

    UUID id;

    Long productDetailID;

    String productName;

    String colorName;

    String sizeName;

    Integer quantity;

    Double totalMoney;

}
