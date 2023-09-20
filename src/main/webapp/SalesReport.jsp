<%@page import="java.util.* "%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="s.css">
    <style>
      body {
        text-align: center;
      }

      h1 {
        background-color: rgb(101, 198, 227);
      }

      div {
        background-color: lightblue;
      }
      
  </style>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sales Report</title>
</head>
<body>
<header>
      <h1>Sales Report</h1> 
    </header>
<%
            @SuppressWarnings("unchecked") 
			int noOfOrders = (int)request.getAttribute("noOfOrders");
			int noOfItemsSold = (int)request.getAttribute("noOfItemsSold");
            int revenue = (int)request.getAttribute("revenue"); 
            
            float revenuePerOrder = 0;
            if(noOfOrders>0){
            	revenuePerOrder = (float)revenue/noOfOrders;
            }
            
            float revenuePerItem = 0;
            if(noOfItemsSold>0){
            	revenuePerItem = (float)revenue/noOfItemsSold;
            }
            %>
      <div>    
            No. of orders: <%=noOfOrders %><br>
            <br>
            <%if(noOfOrders>0){ %>
            Revenue per order: <%=revenuePerOrder %> LKR<br>
            <br>
            <%} %>
            Total no. of items sold: <%=noOfItemsSold %><br>
            <br>
            <%if(noOfItemsSold>0){ %>
            Revenue per item: <%=revenuePerItem %> LKR<br>
            <br>
            <%} %>
            <br>
            <br>
            Total Revenue: <%=revenue %> LKR
       <div>     

</body>
</html>