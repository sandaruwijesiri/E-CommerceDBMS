<%@page import="java.util.* ,java.io.File , com.ecommerce.AttributeNameAndValue , com.ecommerce.Product , com.ecommerce.Variant"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="ISO-8859-1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Product Variants</title>
  <script>
		window.addEventListener( "pageshow", function ( event ) {
			  var historyTraversal = event.persisted || 
			                         ( typeof window.performance != "undefined" && 
			                              window.performance.navigation.type === 2 );
			  if ( historyTraversal ) {
			    // Handle page restore.
			    window.location.reload(true);
			  }
			});
	</script>
  <style>

    @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');

    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: rgb(242, 237, 237);
    }

    h1 {
      text-align: center;
      margin-bottom: 20px;
    }

    .h2 {
      font-size: 70px;
      font-weight: 600;
      background-image: linear-gradient(to left, #553c9a, #b393d3);
      color: transparent;
      background-clip: text;
      -webkit-background-clip: text;
    }

    .submit-btn {
      align-items: center;
      appearance: none;
      background-image: radial-gradient(100% 100% at 100% 0, #5adaff 0, #5468ff 100%);
      border: 0;
      border-radius: 6px;
      box-shadow: rgba(45, 35, 66, .4) 0 2px 4px,rgba(45, 35, 66, .3) 0 7px 13px -3px,rgba(58, 65, 111, .5) 0 -3px 0 inset;
      box-sizing: border-box;
      color: #fff;
      cursor: pointer;
      display: inline-flex;
      font-family: "JetBrains Mono",monospace;
      font-weight: bold;
      height: 48px;
      justify-content: center;
      line-height: 1;
      list-style: none;
      overflow: hidden;
      padding-left: 16px;
      padding-right: 16px;
      position: relative;
      text-align: left;
      text-decoration: none;
      transition: box-shadow .15s,transform .15s;
      user-select: none;
      -webkit-user-select: none;
      touch-action: manipulation;
      white-space: nowrap;
      will-change: box-shadow,transform;
      font-size: 18px;
    }

    .submit-btn:focus {
      box-shadow: #3c4fe0 0 0 0 1.5px inset, rgba(45, 35, 66, .4) 0 2px 4px, rgba(45, 35, 66, .3) 0 7px 13px -3px, #3c4fe0 0 -3px 0 inset;
    }

    .submit-btn:hover {
      box-shadow: rgba(45, 35, 66, .4) 0 4px 8px, rgba(45, 35, 66, .3) 0 7px 13px -3px, #3c4fe0 0 -3px 0 inset;
      transform: translateY(-2px);
    }

    .submit-btn:active {
          box-shadow: #3c4fe0 0 3px 7px inset;
          transform: translateY(2px);
    }

    form {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    label {
    margin-bottom: 10px;
    }

    input[type="text"] {
        height: 25px;
        width: 100px;
        font-size: 16px;
        padding: 0 10px;
    }

    button[type="submit"] {
        background-color: blue;
        color: white;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
    }

    button[type="submit"]:hover {
        background-color: darkblue;
        cursor: pointer;
    }



    form button {
        margin: 0 10px;
    }


    .product {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin: 20px;
      border: 1px solid gray;
      border-radius: 5px;
      padding: 20px;
    }

    .product img {
      width: 400px;
      height: auto;
      margin-bottom: 10px;
    }

    .product p {
      margin: 0;
    }

    .product form {
      margin-top: 20px;
    }

    .product form input {
      margin-right: 10px;
    }

    .footer-copyright{
			background-color: rgb(41, 244, 244);
			position: relative;
			bottom: 0;
			width: 100%;
			text-align: center;
			color: rgb(30, 29, 29);
			font-size: 16px;
			font-weight: bold;
			padding: 5px 0;
		}

  </style>
</head>


<body>
    <div class="hero">
        <h1 style="color: blue; font-size: 32px; text-align: center;">Shop</h1>
        <form action="welcome" method="get">
            <button type="submit" class="submit-btn" name="button" value="ViewCartButton">View Cart</button>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button type="submit" class="submit-btn" name="button" value="ViewOrdersButton">View Orders</button>
        </form>
<%
            Product product = (Product) request.getAttribute("product");
            
if(product!=null){		
    		@SuppressWarnings("unchecked")
			ArrayList<Variant> variants = (ArrayList<Variant>) request.getAttribute("variants");
			%>
        <div class="product">
          <h2 style="color: rgb(0, 0, 0); font-size: 25px; text-align: center;">Product Title: <%= product.productTitle %></h2>
          <p>Weight: <%= product.weightInGrams %> grams</p>
          <br>
          <br>
          <% for (AttributeNameAndValue attr : product.customAttributesOfProduct) { %>
            	<p><%= attr.Name %> : <%= attr.Value %></p>
            <%}%>
          <br>
          <br>
          <% for (Variant variant : variants) { %>
          <img src=<%=variant.imagePath %> alt="product image" style="height: 250px;width: 250px">
          <br>
          <p><strong>Price : <%= variant.priceOfVariant %> LKR</strong></p>
          <br> 
          <p>Quantity Available : <%= variant.quantityAvailable %></p>
          <br>
          <br>
          <% for (AttributeNameAndValue attr : variant.AttributesOfVariant) { %>
            	<%= attr.Name %> : <%= attr.Value %><br>
        <%}%>
          <br>
          <br>
          <form action="welcome" method="get">  
              <label for="quantityToBeOrdered">Enter quantity:&nbsp;&nbsp; </label>
              <input type="number" min="1" name="quantityToBeOrdered" id="quantityToBeOrdered">
              <button type="submit" name="AddToCartButton" value=<%=variant.id %>>Add To Cart</button>
          </form>
          <br>
          <br>
<%}}%>
    </div>
    
    <div class="footer-copyright">
			<p>Copyright © 2022 E-Commerce. All Rights Reserved.</p>
		</div>
  </div>
</body>
</html>
