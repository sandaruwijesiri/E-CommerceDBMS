<%@page import="java.util.* , com.ecommerce.Order , java.text.SimpleDateFormat , java.util.Date "%>

<!DOCTYPE html>
<html>
<head>
	<style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');

        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

		.form-box{
			width: 450px;
			height: 640px;
			position: relative;
			margin: 1% auto;
			background: rgb(177, 241, 243);
			padding: 10px;
			overflow: scroll;
			border-radius: 8px;

		}

		.submit-btn{
			width: 30%;
			padding: 10px 40px;
			cursor: pointer;
			display: block;
			margin: auto;
			background: linear-gradient(to right, #ff105f, #06f3ff);
			border: 0;
			outline: none;
			font-size: 14px;
			border-radius: 30px;
			text-align: center;
		}


        .header {
			font: 20px 'Poppins';
			padding: 10px;
			text-align: center;
			background: linear-gradient(to right, #ff105f, #06f3ff);
			color: rgb(23, 11, 11);
			font-size: 14px;
			border-radius: 8px;
		}

		body {
			text-align: center;
		}

</style>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" >
<title>My Orders</title>
<div class="header">
    <h1>My Orders</h1>
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
</div>
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
<body class="form-box">
	
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
			<button type="submit" class="submit-btn" name="ViewOrderButton" value=<%=order.cartNo %>>View</button>
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