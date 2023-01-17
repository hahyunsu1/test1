package com.mongo.db;

import org.bson.codecs.pojo.annotations.BsonProperty;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PostVO {
	
	@Id
	private String _id;
	
	private String SIGUN_NM;//병원
	private String BIZPLC_NM;//병원이름
	private String LOCPLC_FACLT_TELNO_DTLS;//전화번호
	private String REFINE_WGS84_LOGT;//yyyy
	private String REFINE_WGS84_LAT;//xxxxx
	private String REFINE_ROADNM_ADDR;//도로명주소	
	private String REFINE_LOTNO_ADDR;//	
	

}
