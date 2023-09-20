package com.ecommerce;

public class Order {

	public String username;
	public int cartNo;
	public long orderedTime;
	public long expectedTime;
	public boolean completed;
	public boolean paidByCard;
	public boolean isStorePickup;
	public String feedback;
	
	public Order(String username, int cartNo, long orderedTime, long expectedTime, boolean completed, boolean isStorePickup, boolean paidByCard, String feedback) {

		this.username = username;
		this.cartNo = cartNo;
		this.orderedTime = orderedTime;
		this.expectedTime = expectedTime;
		this.completed = completed;
		this.isStorePickup = isStorePickup;
		this.paidByCard = paidByCard;
		this.feedback = feedback;
	}
}