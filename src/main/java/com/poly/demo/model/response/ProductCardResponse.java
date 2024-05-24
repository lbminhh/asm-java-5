package com.poly.demo.model.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductCardResponse {

    Long productDetailID;

    String productName;

    Double price;

    String colorName;

    String brandName;

    String categoryName;

    String sizeName;

    Integer quantity;

}
