package com.hb.cms.dto.test;

public class TestDto{
	private int no;
	private String name;
	
	public TestDto() {
		
	}
	
	public TestDto(int no,String name) {
		this.no=no;
		this.name=name;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no=no;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name=name;
	}
}