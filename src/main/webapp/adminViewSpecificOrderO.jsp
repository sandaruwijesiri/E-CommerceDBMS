<%@page import="java.util.* , com.ecommerce.AttributeNameAndValue , com.ecommerce.Product , com.ecommerce.Variant , com.ecommerce.Item , com.ecommerce.Order , java.text.SimpleDateFormat , java.util.Date "%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" >
<title>Admin View Order</title>
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
			Order order = (Order) request.getAttribute("order");%>
			
		Username: <%=order.username %><br>
		<br>
		<br>
		<br>
		
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
		<br>
        <% for (AttributeNameAndValue attr : item.variant.AttributesOfVariant) { %>
            	<%= attr.Name %> : <%= attr.Value %><br>
        <%}%>
		<br>
		<br>
		Quantity Ordered : <%= item.quantity %> <br> 
		Total : <%= item.quantity*item.variant.priceOfVariant %> LKR
        
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
	<%String paymentMethod = "Cash On Delivery";
	String deliveryMethod = "Delivery";
	if(order.isStorePickup){
		deliveryMethod = "Store Pickup";
	}
	if(order.paidByCard){
		paymentMethod = "Paid By Card";
	}
	SimpleDateFormat date = new SimpleDateFormat("dd/MM/yyyy");
	String expectedDate = date.format(new Date(order.expectedTime));%>
	Payment method: <%= paymentMethod %><br>
	Delivery Method : <%= deliveryMethod %><br>
	<br>
	Delivery Expected On Or Before: <%=expectedDate %>
	<br>
	<br>
	<%String completionStatus = "On the way";
		if(order.completed){
			completionStatus = "Delivered";
		}%>
	Status: <%=completionStatus %><br>
	<br>
	Feedback : <%=order.feedback %><br>
<br>
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