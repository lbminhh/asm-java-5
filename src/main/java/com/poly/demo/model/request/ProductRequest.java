package com.poly.demo.model.request;

import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductRequest {


    @NotBlank(message = "Không được để trống tên")
    String productName;

    @NotNull(message = "Vui lòng chọn trạng thái")
    Boolean status;

    @NotNull(message = "Vui lòng chọn hãng")
    @Digits(integer = 1, fraction = 0)
    Long brandID;

    @NotNull(message = "Vui lòng chọn thể loại")
    @Digits(integer = 1, fraction = 0)
    Long cateID;

}
