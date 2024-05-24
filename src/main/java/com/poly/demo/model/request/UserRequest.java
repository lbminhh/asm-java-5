package com.poly.demo.model.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserRequest {

    @NotBlank(message = "Vui lòng nhập tên!")
    String fullName;

    @NotBlank(message = "Vui lòng nhập tài khoản!")
    String username;

    @NotBlank(message = "Vui lòng nhập mật khẩu!")
    String password;

    @NotNull(message = "Vui lòng chọn trạng thái!")
    Boolean status;

}
