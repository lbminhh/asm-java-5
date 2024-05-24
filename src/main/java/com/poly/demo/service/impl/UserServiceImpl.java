package com.poly.demo.service.impl;

import com.poly.demo.entity.User;
import com.poly.demo.model.request.UserRequest;
import com.poly.demo.repository.UserRepository;
import com.poly.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;
import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public User login(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password).get();
    }

    @Override
    public String add(UserRequest request) {
        userRepository.save(User.builder()
                .fullName(request.getFullName())
                .password(request.getPassword())
                .username(request.getUsername())
                .roleName("USER")
                .build());
        return "Thêm thành công";
    }

    @Override
    public String update(UserRequest request, UUID id) {
        userRepository.save(User.builder()
                .id(id)
                .fullName(request.getFullName())
                .password(request.getPassword())
                .username(request.getUsername())
                .roleName("USER")
                .build());
        return "Sửa thành công";
    }

    @Override
    public Page<User> getAll(int page) {
        Pageable pageable = PageRequest.of(page - 1, 7);
        return userRepository.getAll(pageable);
    }

    @Override
    public User getUserById(UUID id) {
        return userRepository.findById(id).get();
    }

    @Override
    public User findByUsernameAndPassword(String username, String password) {
        Optional<User> user = userRepository.findByUsernameAndPassword(username, password);
        return user.isEmpty() ? null : user.get();
    }
}
