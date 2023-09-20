package com.ecommerce;

import java.util.ArrayList;

public class Variant {

	public int id;
	public int priceOfVariant;
	public int quantityAvailable;
	public String imagePath;
	public ArrayList<AttributeNameAndValue> AttributesOfVariant;
	
	public Variant(int id, int priceOfVariant, int quantityAvailable, String imagePath, ArrayList<AttributeNameAndValue> AttributesOfVariant) {

		this.id = id;
		this.priceOfVariant = priceOfVariant;
		this.quantityAvailable = quantityAvailable;
		this.imagePath = imagePath;
		this.AttributesOfVariant = AttributesOfVariant;
	}
}