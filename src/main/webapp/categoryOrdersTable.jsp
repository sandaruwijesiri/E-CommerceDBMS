<%@page import="java.util.* , com.ecommerce.CategoryQuantityPair"%>

<!DOCTYPE html>
<html>
<head>
    <style>
        table {
          border-collapse: separate;
          width: 50%;
        }
        
        th, td {
          text-align: center;
          padding: 10px;
        }
        
        tr:nth-child(even){background-color: #f2f2f2}
        
        th {
            background: linear-gradient(to right, #0ad8d8, #686ff0);
            color: rgb(0, 0, 0);
        }

        .header {
			font: 14px 'Poppins';
			padding: 10px 10px;
			text-align: center;
			background: linear-gradient(to right, #6949e9, #06f3ff);
			color: rgb(23, 11, 11);
			font-size: 14px;
			border-radius: 4px;
		}

        .center {
            margin-left: auto;
            margin-right: auto;
        }
        </style>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Orders</title>
</head>
<body>

<div class="header">
    <h1>Category Orders</h1>
</div>

<%
			@SuppressWarnings("unchecked") 
			ArrayList<CategoryQuantityPair> categoryQuantities = (ArrayList<CategoryQuantityPair>) request.getAttribute("categoryQuantities");
            
            %>

<table class="center">
      <tr>
        <th></th>
        <th><font size="+1">Category ID</font></th>
        <th><font size="+1">Category Name</font></th>
        <th><font size="+1">Quantity</font></th>
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