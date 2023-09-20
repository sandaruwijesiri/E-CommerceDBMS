<%@page import="java.util.* , com.ecommerce.AttributeNameAndValue , com.ecommerce.Product , com.ecommerce.Variant , com.ecommerce.Item , com.ecommerce.Order"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback</title>
</head>

<body>
<br>
<br>
<%
			@SuppressWarnings("unchecked") 
			int cartNo = (int) request.getAttribute("cartNo");
			String feedback = (String) request.getAttribute("feedback");
            
            %>
	Feedback can have a maximum of 1000 characters.<br>
	<br>
    <form action="/Servlet01" method="get">
        <p>Enter feedback : </p>
		<br>
        <textarea  name="feedback" rows="10" cols="50" maxlength="1000" autofocus><%=feedback %>
        </textarea><br>
		<br>
		<br>
		<button type="submit" name="SubmitFeedback" value=<%=cartNo %>>Submit Feedback</button>
    </form>
</body>
</html>