package com.poly.demo.service;

import com.poly.demo.entity.Color;
import com.poly.demo.entity.Size;
import com.poly.demo.model.request.ColorRequest;
import com.poly.demo.model.request.SizeRequest;
import org.springframework.data.domain.Page;

import java.util.List;

public interface SizeService {

    List<Size> getAll();

    Page<Size> getAllByPage(int page);

    String add(SizeRequest request);

    String update(SizeRequest request, Long id);

    String delete(Long id);

}
