package com.family.pet.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Select;

import com.family.pet.model.SubCategory;




public interface SubCategoryDao {

	
	
	@Select("select * from SUBCATEGORY where mcategory = '1' order by scaname asc")
	public List<SubCategory> getSubCategory_dog();

	@Select("select * from SUBCATEGORY where mcategory = '2' order by scaname asc")
	public List<SubCategory> getSubCategory_cat();

}
