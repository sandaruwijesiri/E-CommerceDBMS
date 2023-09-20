<%@page import="java.util.* , com.ecommerce.AttributeNameAndValue , com.ecommerce.Product , com.ecommerce.Variant , com.ecommerce.Item , com.ecommerce.Order"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback</title>
	<link rel="stylesheet" href="style.css">
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
			width: 1000px;
			height: 600px;
			position: relative;
			margin: 6% auto;
			background: rgb(245, 242, 242);
			padding: 0px;
			overflow: hidden;
			border-radius: 8px;

		}

        .input-group{
			top: 120px;
			position: absolute;
			width: 280px;
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

        .submit-btn{
			width: 25%;
			padding: 10px 30px;
			cursor: pointer;
			display: block;
			margin: auto;
			background: linear-gradient(to right, #ff105f, #ffad06);
			border: 0;
			outline: none;
			border-radius: 30px;
		}

        #Feedback{
			left: 50px;
		}

        .header {
			font: 20px 'Poppins';
			padding: 10px;
			text-align: center;
			background: #b3d8e9;
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

    </style>
</head>

<body>
<%
			@SuppressWarnings("unchecked") 
			int cartNo = (int) request.getAttribute("cartNo");
			String feedback = (String) request.getAttribute("feedback");
            
            %>
    <div class="hero">
        <div class="form-box">
            <div class="header">
                <h1>Feedback</h1>
            </div>
	Feedback can have a maximum of 1000 characters.<br>
	<br>
    <form action="/Servlet01" method="get">
        <p>Enter feedback : </p>
		<br>
        <textarea  name="feedback" rows="10" cols="133" maxlength="1000" autofocus><%=feedback %>
        </textarea><br>
		<br>
		<br>
		<button type="submit" class="submit-btn" name="SubmitFeedback" value=<%=cartNo %>>Submit Feedback</button>
    </form>
	<div class="footer-copyright">
		<p>Copyright © 2022 E-Commerce. All Rights Reserved.</p>
	</div>
	</div>
	</div>
</body>
</html>