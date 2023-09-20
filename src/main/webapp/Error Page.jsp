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
			width: 400px;
			height: 300px;
			position: relative;
			margin: 6% auto;
			background: rgb(248, 245, 245);
			padding: 5px;
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

    </style>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Message</title>
</head>

<body>
	<%String error = (String)request.getAttribute("error");%>
    <div class="hero">
        <div class="form-box">
            <!-- <div class="header">
                <h1>Login Failed !</h1>
            </div> -->
            <form id="LogIn" class="input-group">
                <h2 style="color:red;"><%=error%></h2>
            </form>
        </div>
		<div class="footer-copyright">
			<p>Copyright © 2022 E-Commerce. All Rights Reserved.</p>
		</div>
    </div>   
</body>
</html>