package com.family.pet.mapper;

import java.util.List;



import org.apache.ibatis.annotations.Select;

import com.family.pet.model.MainCategory;




public interface MainCategoryDao {

	@Select("select * from MAINCATEGORY")
	public List<MainCategory> getMainCategory();
	
}
