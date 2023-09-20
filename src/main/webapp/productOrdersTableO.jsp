<%@page import="java.util.* , com.ecommerce.ProductQuantity"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Orders</title>
</head>
<body>
<h1>Product Orders</h1>

<%
			@SuppressWarnings("unchecked") 
			ArrayList<ProductQuantity> productQuantities = (ArrayList<ProductQuantity>) request.getAttribute("productQuantities");
            
            %>
<table>
      <tr>
        <th></th>
        <th>Product ID</th>
        <th>Product Title</th>
        <th>Quantity</th>
      </tr>
      
      <%for(int i=0;i<productQuantities.size();++i){%>
    	<tr>
        <th><%=(i+1) %></th>
        <th><%=productQuantities.get(i).id %></th>
        <th><%=productQuantities.get(i).title %></th>
        <th><%=productQuantities.get(i).quantity %></th>
        </tr>
      <%} %>
</table>
</body></html>