package com.shop.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.shop.mapper.CategoryMapper;
import com.shop.model.CategoryVO;
import com.shop.model.ProductVO;
@Service
public class AdminServiceImpl implements AdminService {
	@Inject
	private CategoryMapper categoryMapper;
	@Override
	public List<CategoryVO> getUpcategory() {
		// TODO Auto-generated method stub
		return categoryMapper.getUpcategory();
	}

	@Override
	public List<CategoryVO> getDowncategory(String upCg_code) {
		// TODO Auto-generated method stub
		return this.categoryMapper.getDowncategory(upCg_code);
	}

	@Override
	public int categoryAdd(CategoryVO cvo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int categoryDelete(int cg_num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int productInsert(ProductVO prod) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ProductVO> productList() {
		// TODO Auto-generated method stub
		return null;
	}

}
