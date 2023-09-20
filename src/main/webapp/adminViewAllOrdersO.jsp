<%@page import="java.util.* , com.ecommerce.Order , java.text.SimpleDateFormat , java.util.Date "%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" >
<title>Admin View All Orders</title>
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
<br>
<br>
<body>
<%
			@SuppressWarnings("unchecked") 
			ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
            
            
 for (Order order : orders) { 
		
		SimpleDateFormat orderedTime = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		SimpleDateFormat expectedDate = new SimpleDateFormat("dd/MM/yyyy");
		String ordered = orderedTime.format(new Date(order.orderedTime));
		String expected = expectedDate.format(new Date(order.expectedTime));%>
		
		Username: <%=order.username %><br>
		<br>
		
		Ordered At: <%= ordered %><br>
		<%String completionStatus = "On the way";
		if(order.completed){
			completionStatus = "Delivered";
		}
		String paymentMethod = "Cash On Delivery";
		String deliveryMethod = "Delivery";
		if(order.isStorePickup){
			deliveryMethod = "Store Pickup";
		}
		if(order.paidByCard){
			paymentMethod = "Paid By Card";
		}%>
		Payment method: <%= paymentMethod %><br>
		Delivery Method : <%= deliveryMethod %><br>
		Delivery Expected On Or Before: <%= expected %><br>
		Status: <%=completionStatus %><br>
		<br>
		<form action="welcome" method="get">
			<button type="submit" name="AdminViewSpecificOrder" value=<%=order.username + "-" + order.cartNo %>>View</button>
		</form><br>
		<br>
		<br>
<%}%>

<br>
<br>
<br>
<br>
<br>

</body>
</html>