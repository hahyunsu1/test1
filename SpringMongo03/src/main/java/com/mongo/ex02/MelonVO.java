package com.mongo.ex02;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MelonVO {
	
	private int ranking;//노래 순위
	private String songTitle;//노래제목
	private String singer;//가수이름
	private String albumImg;//앨범 이미지 url
}
