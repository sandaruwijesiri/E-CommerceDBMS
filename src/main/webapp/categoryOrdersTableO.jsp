<%@page import="java.util.* , com.ecommerce.CategoryQuantityPair"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Orders</title>
</head>
<body>
<h1>Category Orders</h1>

<%
			@SuppressWarnings("unchecked") 
			ArrayList<CategoryQuantityPair> categoryQuantities = (ArrayList<CategoryQuantityPair>) request.getAttribute("categoryQuantities");
            
            %>
<table>
      <tr>
        <th></th>
        <th>Category ID</th>
        <th>Category Name</th>
        <th>Quantity</th>
      </tr>
      
      <%for(int i=0;i<categoryQuantities.size();++i){%>
    	<tr>
        <th><%=(i+1) %></th>
        <th><%=categoryQuantities.get(i).id %></th>
        <th><%=categoryQuantities.get(i).categoryPath %></th>
        <th><%=categoryQuantities.get(i).quantity %></th>
        </tr>
      <%} %>
</table>
</body></html>