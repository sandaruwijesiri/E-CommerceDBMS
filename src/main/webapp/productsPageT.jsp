<%@page import="java.util.* , com.ecommerce.CategoryOrProductIdAndTitle"%>

<!DOCTYPE html>
<html>
<head>
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Categories and Products</title>
<style>

		
		body {
			background-color: #e8c6c6;
			background-size: cover;
			background-position: absolute;
			
			background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('../assets/Other/productsPageBackground.jpg');
		    background-repeat: no-repeat;
		    background-attachment: fixed;
		    background-size: cover;

		}
		.container {
			width: 100%;
			height: 100vh;
		}
		a {
			text-decoration: none;
			}
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
			font-family: 'Roboto', sans-serif;
				}
		
		.button {
			border: 2px solid black;
			background-color: red;
			color: black;
			padding: 1px 10px;
			font-size: 20px;
			cursor: pointer;
			position: center;
			
		}
		.button_2 {
			margin-bottom: 5%;
			text-align: center;
			border: 2px solid rgb(103, 181, 19);
			background-color:transparent;
			color: rgb(223, 139, 29);
			padding: 15px 20px;
			font-size: 35px;
			cursor: pointer;
			position: center;
			width : 400px;
			
			
		}
		.button_2:hover {
			background-color: rgb(104, 207, 19);
			color: rgb(192, 15, 12);
		}
		.button-div {
			display: flex;
			justify-content: end;
			padding: 1em;
			gap: 20px;
		}
		.button-div_2 {
			display: flex;
			flex-direction: column;
			width: 25%;
			justify-content: center;
			margin: auto;
		}
		.ViewCartButton{
			position: relative;
			border-radius: 20px;
			margin-bottom: 20px;
			border-color: #04AA6D;
			color: rgb(252, 248, 33);
			font-weight: bold;

		}
		.ViewOrderButton{
			position: relative;
			border-radius: 20px;
			margin-bottom: 20px;
			border-color: #04AA6D;
			color: rgb(252, 248, 33);
			font-weight: bold;

		}
		.MobilePhones{
			position: relative;
			border-radius: 20px;
			margin-bottom: 20px;
			border-color: #04AA6D;
			color: rgb(252, 248, 33);
			font-weight: bold;

		}
		.Laptops{
			position: relative;
			border-radius: 20px;
			margin-bottom: 20px;
			border-color: #04AA6D;
			color: rgb(252, 248, 33);
			font-weight: bold;

		}
		.Speaker{
			position: relative;
			border-radius: 20px;
			margin-bottom: 20px;
			border-color: #04AA6D;
			color: rgb(252, 248, 33);
			font-weight: bold;

		}
		.Televisions{
			position: relative;
			border-radius: 20px;
			margin-bottom: 20px;
			border-color: #04AA6D;
			color: rgb(252, 248, 33);
			font-weight: bold;

		}
		.Cameras{
			position: relative;
			border-radius: 20px;
			margin-bottom: 20px;
			border-color: #04AA6D;
			color: rgb(252, 248, 33);
			font-weight: bold;

		}
		.ElectronicToys{
			position: relative;
			border-radius: 20px;
			margin-bottom: 20px;
			border-color: #04AA6D;
			color: rgb(252, 248, 33);
			font-weight: bold;

		}
		.button:hover {
			background-color: #04AA6D;
			color: white;
		}
		.center_1 {
			margin: 0;
			position: relative;
			top: 10%;
			left: 18%;
			-ms-transform: translate(-50%, -50%);
			transform: translate(-50%, -10%);
			padding-left: 900px;;
		}

		.btn-group button {
			background-color: #04AA6D; /* Green background */
			border: 1px solid green; /* Green border */
			color: white; /* White text */
			padding: 10px 24px; /* Some padding */
			cursor: pointer; /* Pointer/hand icon */
			float: left; /* Float the buttons side by side */
		}

		.btn-group button:not(:last-child) {
			border-right: none; /* Prevent double borders */
		}

			/* Clear floats (clearfix hack) */
		.btn-group:after {
			content: "";
			clear: both;
			display: table;
		}

			/* Add a background color on hover */
		.btn-group button:hover {
			background-color: #3e8e41;
		}



</style>
</head>
<body>
<div class="container">
			<form action="welcome" method="get">  
		<div class="btn-group">
					<button class="button ViewCartButton" type="submit" name="button" value="ViewCartButton">View Cart</button>
					<button class="button ViewOrderButton" type="submit" name="button" value="ViewOrdersButton">View Orders</button>
		</div>
			</form>

	<div class= "center_1">
		<form action="welcome" method="get" class="button-div_2">  
		<%
            @SuppressWarnings("unchecked") 
            ArrayList<CategoryOrProductIdAndTitle> categories = (ArrayList<CategoryOrProductIdAndTitle>)request.getAttribute("categories");
			
			if(categories!=null){
	            for (CategoryOrProductIdAndTitle category : categories) { 
	            	String id = String.valueOf(category.id);
	            	String description = category.description;%>
					<button type="submit" class="button_2 Laptops" name="button" value=<%=id %>><%= description %></button><br>
	                 <%
	            }  
			}

            @SuppressWarnings("unchecked") 
            ArrayList<CategoryOrProductIdAndTitle> products = (ArrayList<CategoryOrProductIdAndTitle>)request.getAttribute("products");
            
            if(products!=null){
	            for (CategoryOrProductIdAndTitle category : products) { 
	            	String id = String.valueOf(category.id);
	            	String description = category.description;%>
					<button type="submit" class="button_2 Laptops" name="buttonProduct" value=<%=id %>><%= description %></button><br>
	                 <%
	            } 
			} %>
		</form>	
	</div>
</div>
</body>

</html>   