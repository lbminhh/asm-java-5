package com.poly.demo.model.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailRequest {

    Integer quantity;

    Long productDetailID;

    String orderID;

    String method;

}
