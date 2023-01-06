package com.family.pet.mapper;

import java.util.List;


import org.apache.ibatis.annotations.Select;

import com.family.pet.model.SubCategory;




public interface SubCategoryDao {

	//하나로 합치려면.. 동적 쿼리?
	//추후 리팩토링
	
	@Select("select * from SUBCATEGORY where mcategory = '1' order by scaname asc")
	public List<SubCategory> getSubCategory_dog();

	@Select("select * from SUBCATEGORY where mcategory = '2' order by scaname asc")
	public List<SubCategory> getSubCategory_cat();

}
