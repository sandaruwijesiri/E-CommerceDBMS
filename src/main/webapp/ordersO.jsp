<%@page import="java.util.* , com.ecommerce.Order , java.text.SimpleDateFormat , java.util.Date "%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" >
<title>My Orders</title>
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
		
		Ordered At: <%= ordered %><br>
		Expected On Or Before: <%= expected %><br>
		<%String completionStatus = "On the way";
		if(order.completed){
			completionStatus = "Delivered";
		}%>
		Status: <%=completionStatus %><br>
		<br>
		<form action="welcome" method="get">
			<button type="submit" name="ViewOrderButton" value=<%=order.cartNo %>>View</button>
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