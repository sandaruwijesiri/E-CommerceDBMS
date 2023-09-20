<%@page import="java.util.* , com.ecommerce.AttributeNameAndValue , com.ecommerce.Product , com.ecommerce.Variant , com.ecommerce.Item , com.ecommerce.Order , java.text.SimpleDateFormat , java.util.Date "%>

<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="style.css">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" >
<title>Order</title>
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
  <style>
    body {
  font-family: Arial, sans-serif;
}

header {
  background-color: #333;
  color: white;
  padding: 20px;
  text-align: center;
}

h1 {
  margin: 0;
}

table {
  border-collapse: collapse;
  width: 100%;
}

th,
td {
  border: 1px solid #ddd;
  padding: 5px;
  text-align: left;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}

input[type="number"] {
  width: 60px;
}

button {
  background-color: #4caf50;
  border: none;
  color: white;
  padding: 10px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
}

button:hover {
  background-color: #45a049;
}

.checkout{
    width: 380px;
	height: auto;
	position: relative;
	margin: 6% auto;
	background: rgb(246, 244, 244);
	padding: 10px 10px;
    padding-top: 20px;
	overflow: hidden;
	border-radius: 8px;
    border-style: solid;
  }

  .input-group{
	position: relative;
    width: 280px;
	transition: .5s;
    margin-left: 70px;
	}

  
  .selection{
		width: 80%;
		padding: 10px 10px;
		border: 1px solid #ccc;
		border-radius: 5px;
		background-color: #f8f8f8;
		font-size: 14px;
	}

  .footer-copyright{
		background-color: rgb(41, 244, 244);
		position: relative;
		bottom: 0;
		width: 100%;
		text-align: center;
		color: rgb(30, 29, 29);
		font-size: 16px;
		font-weight: bold;
		padding: 5px 0;
	}

    .btn{
		width: 75%;
        position: center;
		padding: 10px 30px;
		cursor: pointer;
		display: block;
		background: linear-gradient(to right, #ff105f, #ffad06);
		border: 0;
		outline: none;
		border-radius: 30px;
        font-size: 15px;
	}


  </style>
</head>
<body>
  <div>
    <header>
      <h1>Order</h1>
    </header>
<%
			@SuppressWarnings("unchecked") 
			ArrayList<Item> items = (ArrayList<Item>) request.getAttribute("items");
			Order order = (Order) request.getAttribute("order");
            
			%>
    <table>
      <tr>
        <th>Item</th>
        <th>Quantity Ordered</th>
        <th>Price</th>
        <th>Total</th>
      </tr>
      <!-- Add rows for each item in the cart here -->
      <% for (Item item : items) { %>
      <tr>
        <td>
          <h3><b><%= item.product.productTitle %></b></h3><br>
          <img src=<%= item.variant.imagePath %> style="height: 120px;"> <br> 
          <p>Weight: <%= item.product.weightInGrams %> grams</p><br>
          <% for (AttributeNameAndValue attr : item.product.customAttributesOfProduct) { %>
		            	<%= attr.Name %> : <%= attr.Value %><br>
		<%}%><br>


          <% for (AttributeNameAndValue attr : item.variant.AttributesOfVariant) { %>
            	<%= attr.Name %> : <%= attr.Value %><br>
        <%}%>
        </td>
        <td><%= item.quantity %></td>
        <td><%= item.variant.priceOfVariant %> LKR</td>
        <td><%= item.quantity*item.variant.priceOfVariant %> LKR</td>
      </tr>
      <%}%>
    </table>
    <br><br>
    <%int totalPrice=0;
for (Item item : items) {
	totalPrice+=item.quantity*item.variant.priceOfVariant;
}%>
  </div>

  <div class="checkout">
  
  <%String paymentMethod = "Cash On Delivery";
	String deliveryMethod = "Delivery";
	if(order.isStorePickup){
		deliveryMethod = "Store Pickup";
	}
	if(order.paidByCard){
		paymentMethod = "Paid By Card";
	}
	SimpleDateFormat date = new SimpleDateFormat("dd/MM/yyyy");
	String expectedDate = date.format(new Date(order.expectedTime));

	String completionStatus = "On the way";
		if(order.completed){
			completionStatus = "Delivered";
		}%>
		
	<p align="center" style="font-size:160%;"><b>Total: <%=totalPrice %> LKR</b></p>
    <b>Payment method:  </b><%= paymentMethod %><br>
	<b>Delivery Method : </b><%= deliveryMethod %><br>
	<br>
	<b>Delivery Expected On Or Before: </b><%=expectedDate %>
	<br>
	<br>
	<b>Status: </b><%=completionStatus %><br>
	<br>
	<b>Feedback : </b><%=order.feedback %><br><br><br>
    <form class="input-group" action="welcome" method="get">         
    	<%if(!order.completed){ %>
            <button type="submit" class="btn" name="SetAsCompleted" value=<%=order.cartNo %>>Confirm Delivery</button><br>
		<%} %>
            <button type="submit" class="btn" name="SubmitOrEditFeedback" value=<%=order.cartNo %>>Submit Or Edit Feedback</button>
    </form>
  </div>

  <div class="footer-copyright">
    <p>Copyright © 2022 E-Commerce. All Rights Reserved.</p>
  </div>

</body>
</html>