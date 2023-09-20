<%@page import="java.util.* , com.ecommerce.CategoryOrProductIdAndTitle"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Categories and Products</title>
	<style>
		body {
			background-color: #e8c6c6;
			background-size: cover;
			background-position: absolute;

		}

		.container {
			width: 100%;
			height: 100vh;
			background-image: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('../assets/Other/productsPageBackground.jpg');
			background-position: center;
			background-size: cover;
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

			text-align: center;
			border: 2px solid rgb(103, 181, 19);
			background-color: transparent;
			color: rgb(223, 139, 29);
			padding: 10px 2px;
			font-size: 20px;
			cursor: pointer;
			position: relative;
			width: 200px;



		}

		.button_2 {
			margin-bottom: 5%;
			text-align: center;
			border: 2px solid rgb(103, 181, 19);
			background-color: transparent;
			color: rgb(223, 139, 29);
			padding: 5px 2px;
			font-size: 35px;
			cursor: pointer;
			position: relative;
			width: 400px;
			margin: auto;

		}

		.button_2:hover {
			background-color: rgb(104, 207, 19);
			color: rgb(192, 15, 12);
		}

		.button-div {
			display: flex;
			gap: 25px;
			justify-content: center;
			flex-direction: row;
			padding: 20px;
			margin: auto;
			padding-left: 50px;
		}

		.button-div_2 {
			display: flex;

			flex-direction: column;
			width: 50%;
			justify-content: center;
			margin: auto;
		}

		.ViewCartAndOrder  {
			position: relative;
			border-radius: 20px;
			margin-bottom: 20px;
			border-color: #04AA6D;
			color: rgb(252, 248, 33);
			font-weight: bold;

		}

	

		.theButton {
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
			padding-left: 890px;
			;
		}

		.btn-group button {
			background-color: #04AA6D;
			/* Green background */
			border: 1px solid green;
			/* Green border */
			color: white;
			/* White text */
			padding: 20px 24px;
			/* Some padding */
			cursor: pointer;
			/* Pointer/hand icon */
			float: left;
			/* Float the buttons side by side */
			position: center;
			text-align: center;
		}

		.btn-group button:not(:last-child) {
			border-right: none;
			/* Prevent double borders */
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
	<meta charset="ISO-8859-1">

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
</head>
<body>
	<div class="container">
<%
            @SuppressWarnings("unchecked") 
            boolean isAdmin = (boolean)request.getAttribute("isAdmin");
			if(!isAdmin){%>
				<div class="">
					<div class="btn-group">
							<form class="button-div" action="welcome" method="get">  
								<button type="submit" class="button ViewCartAndOrder" name="button" value="ViewCartButton">View Cart</button><br>
								<button type="submit" class="button ViewCartAndOrder" name="button" value="ViewOrdersButton">View Orders</button><br>
							</form>
					</div>
				</div>
		  <%}else{ %>
		  <div class="" style="height: 150px;width: 150px">
		  </div>
		  <%} %>

		<div class="">
				<form class="button-div_2" action="welcome" method="get">  
					<%
            @SuppressWarnings("unchecked") 
            ArrayList<CategoryOrProductIdAndTitle> categories = (ArrayList<CategoryOrProductIdAndTitle>)request.getAttribute("categories");
			
			if(categories!=null){
	            for (CategoryOrProductIdAndTitle category : categories) { 
	            	String id = String.valueOf(category.id);
	            	String description = category.description;%>
	
					<button type="submit" class="button_2 theButton" name="button" value=<%=id %>><%= description %></button><br>
					<%
	            }  
			}

            @SuppressWarnings("unchecked") 
            ArrayList<CategoryOrProductIdAndTitle> products = (ArrayList<CategoryOrProductIdAndTitle>)request.getAttribute("products");
            
            if(products!=null){
	            for (CategoryOrProductIdAndTitle category : products) { 
	            	String id = String.valueOf(category.id);
	            	String description = category.description;%>
					<button type="submit" class="button_2 theButton" name="buttonProduct" value=<%=id %>><%= description %></button><br>
						<%
	            } 
			} %>
			</form>
		</div>
	</div>
</body>

</html>