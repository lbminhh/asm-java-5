package com.poly.demo.service.impl;

import com.poly.demo.entity.Brand;
import com.poly.demo.repository.BrandRepository;
import com.poly.demo.repository.ProductRepository;
import com.poly.demo.service.BrandService;
import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@FieldDefaults(level = AccessLevel.PRIVATE)
public class BrandServiceImpl implements BrandService {

    @Autowired
    BrandRepository brandRepository;

    @Override
    public List<Brand> getAll() {
        return brandRepository.findAll();
    }
}
