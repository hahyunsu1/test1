package com.shop.mapper;

import java.util.List;

import com.shop.model.ReviewVO;

	public interface ReviewMapper {
		List<ReviewVO> listReview();

		int ReviewAdd(ReviewVO rvo);

		int ReviewDel(int num);

		int ReviewEdit(ReviewVO rvo);

		int getTotalCount();

		ReviewVO getReview(int num);
}
