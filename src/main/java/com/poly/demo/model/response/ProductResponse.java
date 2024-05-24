package com.poly.demo.model.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ProductResponse {

    Long id;

    String productName;

    String brandName;

    String cateName;

    Boolean status;

    Long totalQuantity;

}
