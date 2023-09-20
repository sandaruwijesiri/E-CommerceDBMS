<%@page import="java.util.* "%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Time Period With Most Sales</title>
</head>
<body> 
<%
            String productName = (String)request.getAttribute("productName");
			@SuppressWarnings("unchecked") 
			ArrayList<String> months = (ArrayList<String>)request.getAttribute("months");
			@SuppressWarnings("unchecked") 
			ArrayList<Integer> quantity = (ArrayList<Integer>)request.getAttribute("quantity");
			%>
Product Selected: <%=productName %>
<br>
<br>
<%if(months.size()==0){ %>
	No orders for this product yet.
<%}else{ 
int max = Collections.max(quantity);
int index = quantity.indexOf(max);
int prevMax = max;
String month = months.get(index);
months.remove(index);
quantity.remove(index);%>
Most orders for this product was in the month of <%=month %> with <%=max %> orders
<%while(quantity.size()>0 && (max = Collections.max(quantity))==prevMax){
	index = quantity.indexOf(max);
	prevMax = max;
	month = months.get(index);
	months.remove(index);
	quantity.remove(index);%>
	, <%=month %> with <%=max %> orders
<%}
} %>
</body>
</html>