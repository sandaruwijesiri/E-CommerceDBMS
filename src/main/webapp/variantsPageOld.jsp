<%@page import="java.util.* ,java.io.File , com.ecommerce.AttributeNameAndValue , com.ecommerce.Product , com.ecommerce.Variant"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Variants</title>
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

<form action="welcome" method="get">  
<button type="submit" name="button" value="ViewCartButton">View Cart</button>
<button type="submit" name="button" value="ViewOrdersButton">View Orders</button>
</form>
<br>
<br>
<%
            Product product = (Product) request.getAttribute("product");
            
if(product!=null){		
    		@SuppressWarnings("unchecked")
			ArrayList<Variant> variants = (ArrayList<Variant>) request.getAttribute("variants");
			%>

Product Title: <%= product.productTitle %><br>
Weight: <%= product.weightInGrams %> grams<br><br>
<% for (AttributeNameAndValue attr : product.customAttributesOfProduct) { %>
            	<%= attr.Name %> : <%= attr.Value %><br>
            <%}%>

<br>
<br>
<% for (Variant variant : variants) { %>
		<img src=<%=variant.imagePath %> style="height: 120px;"> <br> 
		<br>
		Price : <%= variant.priceOfVariant %> LKR <br> 
		Quantity Available : <%= variant.quantityAvailable %>
		<br>
		<br>
        <% for (AttributeNameAndValue attr : variant.AttributesOfVariant) { %>
            	<%= attr.Name %> : <%= attr.Value %><br>
        <%}%>
        
		<br>
		<br>
		<form action="welcome" method="get">  
			Enter quantity  <input type="number" min="1" name="quantityToBeOrdered">
			<button type="submit" name="AddToCartButton" value=<%=variant.id %>>Add To Cart</button>
		</form>
        
		<br>
		<br>
<%}}%>
</body>
</html>