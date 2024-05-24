package com.poly.demo.repository;

import com.poly.demo.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {

    Optional<User> findByUsernameAndPassword(String userName, String password);

    @Query("SELECT u FROM User u")
    Page<User> getAll(Pageable pageable);

    Optional<User> findByUsername(String username);

}
