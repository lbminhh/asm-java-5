package com.poly.demo.service;

import com.poly.demo.entity.User;
import com.poly.demo.model.request.UserRequest;
import org.springframework.data.domain.Page;

import java.util.UUID;

public interface UserService {

    User login(String username, String password);

    String add(UserRequest request);

    String update(UserRequest request, UUID id);

    Page<User> getAll(int page);

    User getUserById(UUID id);

    User findByUsernameAndPassword(String username, String password);

}
