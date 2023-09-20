package com.ecommerce;

public class CategoryQuantityPair {

	public int id;
	public String categoryPath;
	public int quantity;
	
	public CategoryQuantityPair(int id, String categoryPath, int quantity) {

		this.id = id;
		this.categoryPath = categoryPath;
		this.quantity = quantity;
	}
}