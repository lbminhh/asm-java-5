package com.poly.demo.service;

import com.poly.demo.entity.Color;
import com.poly.demo.model.request.ColorRequest;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ColorService {

    List<Color> getAll();

    Page<Color> getAllByPage(int page);

    String add(ColorRequest request);

    String update(ColorRequest request, Long id);

    String delete(Long id);

}
