<%@page import="java.util.* "%>
<!DOCTYPE html>
<html>
<head>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');

        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .hero{
			height: 100%;
			width: 100%;
			background-image: linear-gradient(rgba(0,0,0,0.4),rgba(0,0,0,0.4)), url('../assets/Other/backgroundGrad.jpg');
			background-position: center;
			background-size: cover;
			position: absolute;
		}

        
		.form-box{
			width: 1500px;
			height: 200px;
			position: relative;
			margin: 6% auto;
			background: rgb(248, 245, 245);
			padding: 5px;
			overflow: hidden;
			border-radius: 8px;

		}

        .input-group{
			top: 50px;
			position: absolute;
			width: 1000px;
			transition: .5s;
		}

		.input-field{
			width: 100%;
			padding: 10px 0;
			margin: 5px 0;
			border-left: 0;
			border-top: 0;
			border-right: 0;
			border-bottom: 1px solid #999;
			outline: none;
			background: transparent;
		}


        #LogIn{
			left: 50px;
		}

        .header {
			font: 20px 'Poppins';
			padding: 10px;
			text-align: center;
			background: #e24b2c;
			color: rgb(23, 11, 11);
			font-size: 14px;
			border-radius: 8px;
		}

		.footer-copyright{
			background-color: rgb(41, 244, 244);
			position: absolute;
			bottom: 0;
			width: 100%;
			text-align: center;
			color: rgb(30, 29, 29);
			font-size: 16px;
			font-weight: bold;
			padding: 10px 0;
		}
		
		.with-breaks {
		  white-space: pre-wrap;
		  color: blue;
		}

    </style>
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
			
String error = "Product Selected: " + productName;
if(months.size()==0){ 
	error += "\n" + "\n" + "No orders for this product yet.";
}else{ 
	int max = Collections.max(quantity);
	int index = quantity.indexOf(max);
	int prevMax = max;
	String month = months.get(index);
	months.remove(index);
	quantity.remove(index);
	error += "\n" + "\n" + "Most orders for this product was in the month of " + month + " with " +max + " orders";
	while(quantity.size()>0 && (max = Collections.max(quantity))==prevMax){
		index = quantity.indexOf(max);
		prevMax = max;
		month = months.get(index);
		months.remove(index);
		quantity.remove(index);
		error += ", " + month + " with " + max + " orders";
	}
	error += ".";
} %>
    <div class="hero">
        <div class="form-box">
            <!-- <div class="header">
                <h1>Login Failed !</h1>
            </div> -->
            <form id="LogIn" class="input-group">
                <h2 class="with-breaks" style="color:red;"><%=error%></h2>
            </form>
        </div>
		<div class="footer-copyright">
			<p>Copyright © 2022 E-Commerce. All Rights Reserved.</p>
		</div>
    </div>   
</body>
</html>