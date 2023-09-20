<%@page import="java.util.* , com.ecommerce.Methods"%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="s.css">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Web Application</title>
</head>
<body>
<h1>Welcome</h1>  
<ul>  
  <li><a href="#" id="idd">HHHHHHHH</a></li>  
  <li><a href="#">News</a></li>  
  <li><a href="#">Contact</a></li>  
  <li><a href="#">About</a></li>  
</ul>  

<form action="welcome" method="get">  
<hr><%
            @SuppressWarnings("unchecked") 
            ArrayList<String> guests2 = (ArrayList<String>)request.getAttribute("attr");
			
            for (String guest : guests2) { %>
				<button type="submit" class="b1" name="button" value=<%=guest %>><%= guest %></button><br>
                 <%
            }  %> <hr>
</form>
<form action="welcome" method="get">  
Enter your name<input type="text" name="name"><br>  
<input type="submit" value="login">  
<button type="submit" class="btn font-baloo text-danger" name="button" value="SaveButton">Save for Later</button>
<button type="submit" class="btn font-baloo text-danger" name="button" value="SaveButton2">Save for Later11111111</button>
</form>

</body>
</html>