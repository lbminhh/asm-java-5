package com.poly.demo.model.response;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@AllArgsConstructor
@NoArgsConstructor
@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductDetailResponse {

    Long id;

    String productName;

    Double price;

    String colorName;

    String sizeName;

    Integer quantity;

    Boolean status;

}
