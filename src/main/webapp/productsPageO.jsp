<%@page import="java.util.* , com.ecommerce.CategoryOrProductIdAndTitle"%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="s.css">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Categories and Products</title>
</head>
<body>
<%
            @SuppressWarnings("unchecked") 
            boolean isAdmin = (boolean)request.getAttribute("isAdmin");
			if(!isAdmin){%>
<form action="welcome" method="get">  
	<button type="submit" name="button" value="ViewCartButton">View Cart</button>
	<button type="submit" name="button" value="ViewOrdersButton">View Orders</button>
</form>
<%} %>

<form action="welcome" method="get">  
<hr><%
            @SuppressWarnings("unchecked") 
            ArrayList<CategoryOrProductIdAndTitle> categories = (ArrayList<CategoryOrProductIdAndTitle>)request.getAttribute("categories");
			
			if(categories!=null){
	            for (CategoryOrProductIdAndTitle category : categories) { 
	            	String id = String.valueOf(category.id);
	            	String description = category.description;%>
					<button type="submit" class="b1" name="button" value=<%=id %>><%= description %></button><br>
	                 <%
	            }  
			}

            @SuppressWarnings("unchecked") 
            ArrayList<CategoryOrProductIdAndTitle> products = (ArrayList<CategoryOrProductIdAndTitle>)request.getAttribute("products");
            
            if(products!=null){
	            for (CategoryOrProductIdAndTitle product : products) { 
	            	String id = String.valueOf(product.id);
	            	String description = product.description;%>
					<button type="submit" class="b1" name="buttonProduct" value=<%=id %>><%= description %></button><br>
	                 <%
	            } 
			} %>
</form>

</body>
</html>