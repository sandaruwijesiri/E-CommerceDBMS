package com.ecommerce;

public class Item {

	public int quantity;
	public Product product;
	public Variant variant;
	
	public Item(int quantity, Product product, Variant variant) {
		this.quantity = quantity;
		this.product = product;
		this.variant = variant;
	}
}