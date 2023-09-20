<%@page import="java.util.* "%>
<! DOCTYPE html>
<html>
    <head>
		<meta charset="ISO-8859-1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Message</title>
    </head>
        
        <body>
        <%String error = (String)request.getAttribute("error");%>
        <p><%=error%></p>
        </body>




</html>