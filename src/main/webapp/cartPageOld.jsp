<%@page import="java.util.* , com.ecommerce.AttributeNameAndValue , com.ecommerce.Product , com.ecommerce.Variant , com.ecommerce.Item"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" >
<title>My Cart</title>
	<script>
		window.addEventListener( "pageshow", function ( event ) {
			  var historyTraversal = event.persisted || 
			                         ( typeof window.performance != "undefined" && 
			                              window.performance.navigation.type === 2 );
			  if ( historyTraversal ) {
			    // Handle page restore.
			    window.location.reload(true);
			  }
			});
	</script>
</head>
<body>

<br>
<br>
<%
			@SuppressWarnings("unchecked") 
			ArrayList<Item> items = (ArrayList<Item>) request.getAttribute("items");
			int days = (int) request.getAttribute("days");
            
            %>

<% for (Item item : items) { %>
		Product Title: <%= item.product.productTitle %><br>
		Weight: <%= item.product.weightInGrams %> grams<br><br>
		<% for (AttributeNameAndValue attr : item.product.customAttributesOfProduct) { %>
		            	<%= attr.Name %> : <%= attr.Value %><br>
		<%}%>
		<br>
		<br>
		<img src=<%= item.variant.imagePath %> style="height: 120px;"> <br> 
		<br>
		Price : <%= item.variant.priceOfVariant %> LKR <br> 
		Quantity Available : <%= item.variant.quantityAvailable %>
		<br>
		<br>
        <% for (AttributeNameAndValue attr : item.variant.AttributesOfVariant) { %>
            	<%= attr.Name %> : <%= attr.Value %><br>
        <%}%>
		<br>
		<br>
		Quantity in cart : <%= item.quantity %> <br> 
		Total : <%= item.quantity*item.variant.priceOfVariant %> LKR
        
		<br>
		<br>
		<form action="welcome" method="get">
			<button type="submit" name="RemoveFromCartButton" value=<%=item.variant.id %>>Remove From Cart</button>
		</form>
        
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
<%}%>

<%int totalPrice=0;
for (Item item : items) {
	totalPrice+=item.quantity*item.variant.priceOfVariant;
}%>
Total Price : <%=totalPrice %> LKR<br>
<br>
<form action="welcome" method="get">
	Payment method: <select name="paymentMethod" id="paymentMethodID">
					  <option value="PayByCardSelected">Pay By Card</option>
					  <option value="CashOnDeliverySelected">Cash On Delivery</option>
					</select><br>
	<br>
	Delivery Method : <select name="deliveryMethod" id="deliveryMethodID">
						  <option value="DeliverToMyAddressSelected">Deliver To My Address</option>
						  <option value="StorePickupSelected">Store Pickup</option>
					  </select><br>
	<br>
	<br>
	Expected Delivery In: <%=days %> Days
	<br>
	<br>
	<button type="submit" name="CheckoutButton" value=<%=days %>>Checkout</button>

</form><br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

</body>
</html>