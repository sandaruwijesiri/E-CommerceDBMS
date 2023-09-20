package com.ecommerce;

import java.util.ArrayList;

public class Product {

	public String productTitle;
	public int weightInGrams;
	public ArrayList<AttributeNameAndValue> customAttributesOfProduct;
	
	public Product(String productTitle, int weightInGrams, ArrayList<AttributeNameAndValue> customAttributesOfProduct) {

		this.productTitle = productTitle;
		this.weightInGrams = weightInGrams;
		this.customAttributesOfProduct = customAttributesOfProduct;
	}
}