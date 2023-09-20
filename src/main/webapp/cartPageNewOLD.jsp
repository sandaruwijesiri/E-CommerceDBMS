<%@page import="java.util.* , com.ecommerce.AttributeNameAndValue , com.ecommerce.Product , com.ecommerce.Variant , com.ecommerce.Item"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" >
<title>My Cart</title>
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

    .cart-page{
        margin: 80px auto;
    }

    table{
        width: 90%;
        border-collapse: collapse;
        margin-left: auto;
        margin-right: auto;
    }

    .cart-info{
        display: flex;
        flex-wrap: wrap;
    }

    th{
        text-align: left;
        padding: 10px;
        color: #fff;
        background: #ff523b;
        font-weight: bold;
    }

    td{
        padding: 10px 5px;
    }

    td a{
        color: #ff523b;
        font-size: 15px;
    }

    td img{
        width: 200px;
        height: 150px;
        margin-right: 10px;
    }

    .total-price{
        display: flex;
        justify-content: flex-end;
    }

    .total-price table{
        border-top: 3px solid #ff523b;
        width: 90%;
        max-width: 350px;
        margin-right: 70px;
    }

    td:last-child{
        text-align: right;
    }

    th:last-child{
        text-align: right;
    }

    .checkout{
        width: 380px;
		height: 300px;
		position: relative;
		margin: 6% auto;
		background: rgb(246, 244, 244);
		padding: 5px;
		overflow: scroll;
		border-radius: 8px;
		bottom: 20px;
        border-style: solid;
    }

    .selection{
		width: 80%;
		padding: 10px 10px;
		border: 1px solid #ccc;
		border-radius: 5px;
		background-color: #f8f8f8;
		font-size: 14px;
	}

    .input-group{
		position: absolute;
		width: 280px;
		transition: .5s;
        margin-left: 80px;
	}

    .submit-btn{
		width: 85%;
		padding: 10px 30px;
		cursor: pointer;
		display: block;
		margin-right: 70px;
		background: linear-gradient(to right, #ff105f, #ffad06);
		border: 0;
		outline: none;
		border-radius: 30px;
        font-size: 20px;
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
        <div class="small-container cart-page">
            <table>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Sub Total</th>
                </tr>
                <%
			@SuppressWarnings("unchecked") 
			ArrayList<Item> items = (ArrayList<Item>) request.getAttribute("items");
			int days = (int) request.getAttribute("days");
            
            %>
            <% for (Item item : items) { %>
                <tr>
                    <td>
                        <div class="cart-info">
                            <img src=<%= item.variant.imagePath %> >
                            <div>
                                <h3><b>Product Title: <%= item.product.productTitle %></b></h3>
                                <p>Weight: <%= item.product.weightInGrams %> grams</p><br>
                                <% for (AttributeNameAndValue attr : item.product.customAttributesOfProduct) { %>
		            	<%= attr.Name %> : <%= attr.Value %><br>
		<%}%><br>

                                <b>Price : <%= item.variant.priceOfVariant %> LKR</b><br> 
                                Quantity Available : <%= item.variant.quantityAvailable %><br><br>

<% for (AttributeNameAndValue attr : item.variant.AttributesOfVariant) { %>
            	<%= attr.Name %> : <%= attr.Value %><br>
        <%}%><br>
                                
                                <form action="welcome" method="get">
                                    <button type="submit" name="RemoveFromCartButton" value=<%=item.variant.id %>>Remove From Cart</button>
                                </form>
                                <br><br>
                            </div>
                        </div>
                    </td>
                    <td><%= item.quantity %> </td>
                    <td><%= item.quantity*item.variant.priceOfVariant %> LKR</td>
                </tr>
                <%}%>
            </table>
<%int totalPrice=0;
for (Item item : items) {
	totalPrice+=item.quantity*item.variant.priceOfVariant;
}%>
            <div class="total-price">
                <table>
                    <tr>
                        <td><b>Total</b></td>
                        <td><b><%=totalPrice %> LKR</b></td>
                    </tr>
                </table>
            </div>


            <div class="checkout">
                <form class="input-group" action="welcome" method="get">
                    Payment method: <br><br><select name="paymentMethod" class="selection" id="paymentMethodID">
                                    <option value="PayByCardSelected">Pay By Card</option>
                                    <option value="CashOnDeliverySelected">Cash On Delivery</option>
                                    </select><br><br>
                
                    Delivery Method: <br><br><select name="deliveryMethod" class="selection" id="deliveryMethodID">
                                        <option value="DeliverToMyAddressSelected">Deliver To My Address</option>
                                        <option value="StorePickupSelected">Store Pickup</option>
                                    </select><br>
	<br>
	<br>
	Expected Delivery In: <%=days %> Days
	<br><br>
                
                    <button type="submit" class="submit-btn" name="CheckoutButton" value=<%=days %>>Checkout</button>
                
                </form>
            </div>

        </div>

        <div class="footer-copyright">
            <p>Copyright © 2022 E-Commerce. All Rights Reserved.</p>
        </div>
    </div>
</body>