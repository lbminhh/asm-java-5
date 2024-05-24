package com.poly.demo.model.request;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder
public class ProductDetailRequest {

    @NotNull(message = "Sản phẩm không thể trống.")
    Long productID;

    @NotNull(message = "Vui lòng chọn màu sắc!")
    Long colorID;

    @NotNull(message = "Vui lòng chọn kích cỡ!")
    Long sizeID;

    @NotNull(message = "Vui lòng chọn trạng thái!")
    Boolean status;

    @NotNull(message = "Vui lòng nhập số lượng!")
    @Min(value = 1, message = "Số lượng phải lớn hơn 0")
    Integer quantity;

    @NotNull(message = "Vui lòng nhập giá!")
    @Min(value = 10000, message = "Giá phải lớn hơn 10,000!")
    Double price;

}
