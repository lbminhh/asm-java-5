package com.poly.demo.repository;

import com.poly.demo.entity.Color;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ColorRepository extends JpaRepository<Color, Long> {

    @Query("SELECT c FROM Color c")
    Page<Color> getAllByPage(Pageable pageable);

}
