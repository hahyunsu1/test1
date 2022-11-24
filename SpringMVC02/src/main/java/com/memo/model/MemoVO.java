package com.memo.model;
import java.util.*;
import lombok.*;


@Setter
@Getter
@ToString(includeFieldNames = true)
public class MemoVO {

	private int idx;
	private String name;
	private String msg;
	private Date wdate;
}
