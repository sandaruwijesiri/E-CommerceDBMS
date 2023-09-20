

import java.io.IOException;











import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.*;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Cookie;

import com.ecommerce.UsersAndPasswords;
import com.ecommerce.AttributeNameAndValue;
import com.ecommerce.Product;
import com.ecommerce.Variant;
import com.ecommerce.Item;
import com.ecommerce.CategoryOrProductIdAndTitle;
import com.ecommerce.Order;
import com.ecommerce.ProductQuantity;
import com.ecommerce.CategoryQuantityPair;

/**
 * Servlet implementation class Servlet01
 */
@WebServlet("/Servlet01")
public class Servlet01 extends HttpServlet {
	int limit=0;

    String alphabetAndNumbersAndUnderscore = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_";
    String digits = "0123456789";
	private static final long serialVersionUID = 1L;
	
	PreparedStatement createAcc = null;
	PreparedStatement createCartForUserID = null;
	PreparedStatement getUserPassword = null;
	PreparedStatement getCategoryDescriptionFromId = null;
	PreparedStatement getSubCategoryIDFromCategoryId = null;
	PreparedStatement getProductDescriptionFromId = null;
	PreparedStatement getProductDataFromId = null;
	PreparedStatement getAttributesFromProductID = null;
	PreparedStatement getProductIDFromCategoryId = null;
	PreparedStatement getVariantDataFromProductID = null;
	PreparedStatement getAttributesFromVariantID = null;
	PreparedStatement getUserIDFromUsername = null;
	PreparedStatement getCartNOFromUserID = null;
	PreparedStatement getItemDataFromUserIDAndCartNO = null;
	PreparedStatement getVariantDataFromVariantID = null;
	PreparedStatement addToCart = null;
	PreparedStatement updateVariantQuantityAvailable = null;
	PreparedStatement getQuantityFromItemForUserIDCartNoAndVariantId = null;
	PreparedStatement updateItemQuantity = null;
	PreparedStatement getItemDataFromUserIDAndCartNo = null;
	PreparedStatement removeItemFromCart = null;
	PreparedStatement getUserCityFromUsername = null;
	PreparedStatement checkout = null;
	PreparedStatement incrementCartNo = null;
	PreparedStatement getOrdersFromUserID = null;
	PreparedStatement getOrderFromUserIDAndCartNo = null;
	PreparedStatement setOrderAsCompleted = null;
	PreparedStatement getFeedbackFromUserIDAndCartNo = null;
	PreparedStatement setFeedbackFromUserIDAndCartNo = null;
	PreparedStatement getUsernameFromUserId = null;
	PreparedStatement getAllOrders = null;
	PreparedStatement getAdminPassword = null;
	PreparedStatement getTotalQuantityForProductsWithTimePeriod = null;
	PreparedStatement getTotalQuantityForCategories = null;
	PreparedStatement getCategoriesWithProducts = null;
	PreparedStatement getSuperCategoryID = null;
	PreparedStatement getUserIDAndCartNOFromTimePeriod = null;
	PreparedStatement getVariantPriceFromVariantID = null;
	PreparedStatement getQuantityAndOrderedTimeGivenAProduct = null;
	
	Connection con = null;
	
    /**
     * Default constructor.
     */
    public Servlet01() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		if(con==null) {
			try{
				Class.forName("com.mysql.jdbc.Driver");
				con=DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/e-commerce_database","root","password");
				//here sonoo is database name, root is username and password
				
				createAcc = con.prepareStatement("insert into user(User_name,Password,First_name,Last_name,Telephone_No,City,Address) values(?,?,?,?,?,?,?)");
				createCartForUserID = con.prepareStatement("insert into cart(User_id,Cart_No) values(?,?)");
				getUserPassword = con.prepareStatement("select Password from user where User_name=?");
				getCategoryDescriptionFromId = con.prepareStatement("select Description from category where ID=?");
				getSubCategoryIDFromCategoryId = con.prepareStatement("select SubCategory_ID from subcategory where Category_ID=?");
				getProductDescriptionFromId = con.prepareStatement("select Title from product where ID=?");
				getProductDataFromId = con.prepareStatement("select Title,weightInGrams from product where ID=?");
				getAttributesFromProductID = con.prepareStatement("select AttributeName,AttributeValue from customattributeproducts where Product_ID=?");
				getProductIDFromCategoryId = con.prepareStatement("select Product_ID from productsincategory where Category_ID=?");
				getVariantDataFromProductID = con.prepareStatement("select ID,Price,QuantityAvailable,ImagePath from variant where Product_ID=?");
				getAttributesFromVariantID = con.prepareStatement("select AttributeName,AttributeValue from attribute_variant where Variant_ID=?");
				
				getUserIDFromUsername = con.prepareStatement("select User_id from user where User_name=?");
				getCartNOFromUserID = con.prepareStatement("select Cart_No from cart where User_id=?");
				getItemDataFromUserIDAndCartNO = con.prepareStatement("select Quantity,Variant_ID from item where User_id=? and Cart_No=?");
				getVariantDataFromVariantID = con.prepareStatement("select Product_ID,Price,QuantityAvailable,ImagePath from variant where ID=?");
				addToCart = con.prepareStatement("insert into item(User_id,Cart_No,Quantity,Variant_ID) values(?,?,?,?)");
				updateVariantQuantityAvailable = con.prepareStatement("update variant set QuantityAvailable=QuantityAvailable+? where ID=?");
				getQuantityFromItemForUserIDCartNoAndVariantId = con.prepareStatement("select Quantity from item where User_id=? and Cart_No=? and Variant_ID=?");
				updateItemQuantity = con.prepareStatement("update item set Quantity=Quantity+? where User_id=? and Cart_No=? and Variant_ID=?");
				getItemDataFromUserIDAndCartNo = con.prepareStatement("select Quantity,Variant_ID from item where User_id=? and Cart_No=?");
				removeItemFromCart = con.prepareStatement("delete from item where User_id=? and Cart_No=? and Variant_ID=?");
				getUserCityFromUsername = con.prepareStatement("select City from user where User_name=?");
				checkout = con.prepareStatement("insert into theorder(User_id,Cart_No,OrderedTime,ExpectedTime,Completed,IsStorePickup,PaidByCard,Feedback) values(?,?,?,?,?,?,?,?)");
				incrementCartNo = con.prepareStatement("update cart set Cart_No=Cart_No+1 where User_id=?");
				getOrdersFromUserID = con.prepareStatement("select Cart_No,OrderedTime,ExpectedTime,Completed from theorder where User_id=? order by OrderedTime desc");
				getOrderFromUserIDAndCartNo = con.prepareStatement("select OrderedTime,ExpectedTime,Completed,IsStorePickup,PaidByCard,Feedback from theorder where User_id=? and Cart_No=?");
				setOrderAsCompleted = con.prepareStatement("update theorder set Completed=true where User_id=? and Cart_No=?");
				getFeedbackFromUserIDAndCartNo = con.prepareStatement("select Feedback from theorder where User_id=? and Cart_No=?");
				setFeedbackFromUserIDAndCartNo = con.prepareStatement("update theorder set Feedback=? where User_id=? and Cart_No=?");
				
				getUsernameFromUserId = con.prepareStatement("select User_name from user where User_id=?");
				getAllOrders = con.prepareStatement("select * from theorder order by User_id");
				getAdminPassword = con.prepareStatement("select Password from admin where Admin_name=?");

				getTotalQuantityForProductsWithTimePeriod = con.prepareStatement("select product.ID,product.Title,sum(Quantity) from item inner join theorder on (item.User_id=theorder.User_id and item.Cart_No=theorder.Cart_No and theorder.OrderedTime>? and theorder.OrderedTime<?) inner join variant on variant.ID=item.Variant_ID inner join product on variant.Product_ID=product.ID group by product.ID");
				getTotalQuantityForCategories = con.prepareStatement("select productsincategory.Category_ID,sum(Quantity) from item inner join theorder on (item.User_id=theorder.User_id and item.Cart_No=theorder.Cart_No) inner join variant on variant.ID=item.Variant_ID inner join productsincategory on variant.Product_ID=productsincategory.Product_ID group by productsincategory.Category_ID");
				getCategoriesWithProducts = con.prepareStatement("select Category_ID from productsincategory");
				getSuperCategoryID = con.prepareStatement("select Category_ID from subcategory where SubCategory_ID=?");

				getUserIDAndCartNOFromTimePeriod = con.prepareStatement("select User_id,Cart_No from theorder where OrderedTime>? and OrderedTime<?");
				getVariantPriceFromVariantID = con.prepareStatement("select Price from variant where ID=?");
				getQuantityAndOrderedTimeGivenAProduct = con.prepareStatement("select item.Quantity,theorder.OrderedTime from item inner join theorder on (item.User_id=theorder.User_id and item.Cart_No=theorder.Cart_No) inner join variant on (variant.ID=item.Variant_ID and variant.Product_ID=?)");
			}catch(Exception e){ e.printStackTrace();}
		}
		
		Cookie ck[]=request.getCookies();

		String buttonClicked = request.getParameter("button");
		ArrayList<CategoryOrProductIdAndTitle> categories = new ArrayList<>();
		ArrayList<CategoryOrProductIdAndTitle> products = new ArrayList<>();

		if(buttonClicked!=null) {
			if("loginButton".equals(buttonClicked)) {
				clearCookies(ck,response);
				request.getRequestDispatcher("/Login Page.html")
		        .forward(request, response);
				return;
			}else if("createAccButton".equals(buttonClicked)) {
				clearCookies(ck,response);
				request.getRequestDispatcher("/Create Account Page.html")
		        .forward(request, response);
				return;
			}else if("guestButton".equals(buttonClicked)) {
				clearCookies(ck,response);
				goingToHomePage(categories);
				Cookie cookie=new Cookie("username","*");
				response.addCookie(cookie);
				request.setAttribute("isAdmin",false);
			}else if("adminButton".equals(buttonClicked)) {
				clearCookies(ck,response);
				request.getRequestDispatcher("/adminLogin.html")
		        .forward(request, response);
				return;
			}else if("loginToAcc".equals(buttonClicked)) {
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				
				try {
					getUserPassword.setString(1, username);
					ResultSet rs=getUserPassword.executeQuery();
					if(rs.next()) {
						if(rs.getString(1).equals(password) ) {
							goingToHomePage(categories);
							Cookie cookie=new Cookie("username",username);
							cookie.setMaxAge(-1);
							response.addCookie(cookie);
							request.setAttribute("categories",categories);
							request.setAttribute("isAdmin",false);
							request.getRequestDispatcher("/productsPage.jsp")
					        .forward(request, response);
							return;
						}
					}
				} catch (SQLException e) {
					e.printStackTrace();
					showMessage(request,response,"Error logging in.");
					return;
				}
				
				showMessage(request,response,"Invalid username or password.");
				return;
				
				
			}else if("AdminLogin".equals(buttonClicked)) {
				String admin_name = request.getParameter("admin_name");
				String password = request.getParameter("password");
				
				try {
					getAdminPassword.setString(1, admin_name);
					ResultSet rs=getAdminPassword.executeQuery();
					if(rs.next()) {
						if(rs.getString(1).equals(password) ) {
							Cookie cookie=new Cookie("Admin_name",admin_name);
							cookie.setMaxAge(-1);
							response.addCookie(cookie);
							request.getRequestDispatcher("/adminPage.html")
					        .forward(request, response);
							return;
						}
					}
				} catch (SQLException e) {
					e.printStackTrace();
					showMessage(request,response,"Error logging in.");
					return;
				}
				
				showMessage(request,response,"Invalid admin_name or password.");
				return;
				
				
			}else if("createAcc".equals(buttonClicked)) {
				String pass = request.getParameter("pass");
				String repass = request.getParameter("repass");
				String username = request.getParameter("username");
				
				// Check username
				String message = validateUsername(username);
				if(!("".equals(message))) {
					showMessage(request,response,message);
					return;
				}
				
				try {
					getUserPassword.setString(1, username);
					ResultSet rs=getUserPassword.executeQuery();
					if(rs.next()) {
						showMessage(request,response,"Username already taken.");
						return;
					}
				} catch (SQLException e) {
					e.printStackTrace();
					showMessage(request,response,"Error creating account.");
					return;
				}
	
				// Check password
				message = validatePassword(pass,repass);
				if(!("".equals(message))) {
					showMessage(request,response,message);
					return;
				}
	
				
		        String phone = request.getParameter("phone");
				// Check phoneNumber
				message = validatePhone(phone);
				if(!("".equals(message))) {
					showMessage(request,response,message);
					return;
				}
	
		        String firstName = request.getParameter("firstname");
		        String lastName = request.getParameter("lastname");
		        String city = request.getParameter("city");
		        String address = request.getParameter("address");
		        
		        message = "";
		        if(firstName.length()>20) {
		        	message = "First name can have  a maximum of 20 characters.";
		        }else if(lastName.length()>20){
		        	message = "Last name can have  a maximum of 20 characters.";
		        }else if(address.length()>100){
		        	message = "Address name can have  a maximum of 100 characters.";
		        }
		        
				if(!("".equals(message))) {
					showMessage(request,response,message);
					return;
				}
				try {
			        createAcc.setString(1, username);
			        createAcc.setString(2, pass);
			        createAcc.setString(3, firstName);
			        createAcc.setString(4, lastName);
			        createAcc.setString(5, phone);
			        createAcc.setString(6, city);
			        createAcc.setString(7, address);
			        try {
						con.setAutoCommit(false);
				        createAcc.executeUpdate();
				        
				        getUserIDFromUsername.setString(1, username);
				        ResultSet rs = getUserIDFromUsername.executeQuery();
				        if(rs.next()) {
				        	createCartForUserID.setInt(1, rs.getInt(1));
				        	createCartForUserID.setInt(2,0);
				        	createCartForUserID.executeUpdate();
				        }
						con.commit();
						con.setAutoCommit(true);
			        }catch(Exception e) {
						con.rollback();
						con.setAutoCommit(true);
						e.printStackTrace();
						showMessage(request,response,"Error creating account.");
						return;
			        }
				}catch(Exception e) {
					e.printStackTrace();
					showMessage(request,response,"Error creating account.");
					return;
				}
				
				goingToHomePage(categories);
				Cookie cookie=new Cookie("username",username);
				response.addCookie(cookie);
				request.setAttribute("categories",categories);
				request.setAttribute("isAdmin",false);
		        request.getRequestDispatcher("/productsPage.jsp")
		        .forward(request, response);
				return;
			}else if("ViewCartButton".equals(buttonClicked)){
				for(Cookie cookie:ck) {
					if("username".equals(cookie.getName())) {
						String username = cookie.getValue();
						if("*".equals(username)) {
							showMessage(request,response,"Please log in or create account to view your cart.");
							return;
						}
						ArrayList<Item> items = new ArrayList<>();
						int days = 5;
						int stockFactor=0;

						try {
							getUserCityFromUsername.setString(1,username);
							ResultSet CityRS = getUserCityFromUsername.executeQuery();
							if(CityRS.next()){
								if("Other".equals(CityRS.getString(1))) {
									days+=2;
								}
							}
							getUserIDFromUsername.setString(1, username);
							ResultSet UserID = getUserIDFromUsername.executeQuery();
							if(UserID.next()) {
								int uID = UserID.getInt(1);
								getCartNOFromUserID.setInt(1, uID);
								ResultSet CartNO = getCartNOFromUserID.executeQuery();
								if(CartNO.next()) {
									int cartno = CartNO.getInt(1);
									getItemDataFromUserIDAndCartNo.setInt(1, uID);
									getItemDataFromUserIDAndCartNo.setInt(2, cartno);
									ResultSet variantsAndQuantities = getItemDataFromUserIDAndCartNo.executeQuery();
									while(variantsAndQuantities.next()) {
										Item item;
										int quantityOrdered = variantsAndQuantities.getInt(1);
										int varID = variantsAndQuantities.getInt(2);
										getVariantDataFromVariantID.setInt(1, varID);
										ResultSet vardata = getVariantDataFromVariantID.executeQuery();
										if(vardata.next()) {
											int productID = vardata.getInt(1);
											int price = vardata.getInt(2);
											int quantityAvailable = vardata.getInt(3);
											String imagePath = vardata.getString(4);
											ArrayList<AttributeNameAndValue> AttributesOfVariant = new ArrayList<>();
											getAttributesFromVariantID.setInt(1, varID);
											ResultSet varAttr = getAttributesFromVariantID.executeQuery();
											while(varAttr.next()) {
												AttributesOfVariant.add(new AttributeNameAndValue(varAttr.getString(1),varAttr.getString(2)));
											}
											if(quantityAvailable<0) {
												quantityAvailable=0;
												stockFactor=3;
											}
											Variant variant = new Variant(varID,price,quantityAvailable,imagePath,AttributesOfVariant);

											getProductDataFromId.setInt(1, productID);
											ResultSet productdata = getProductDataFromId.executeQuery();
											if(productdata.next()) {
												String productTitle = productdata.getString(1);
												int productWeight = productdata.getInt(2);
												ArrayList<AttributeNameAndValue> AttributesOfProduct = new ArrayList<>();
												getAttributesFromProductID.setInt(1, productID);
												ResultSet productAttr = getAttributesFromProductID.executeQuery();
												while(productAttr.next()) {
													AttributesOfProduct.add(new AttributeNameAndValue(productAttr.getString(1),productAttr.getString(2)));
												}
												Product product = new Product(productTitle,productWeight,AttributesOfProduct);
												item = new Item(quantityOrdered, product, variant);
												items.add(item);
											}
										}
									}
								}
							}
						}catch(Exception e) {
							e.printStackTrace();
							showMessage(request,response,"Error viewing cart.");
							return;
						}
						
						if(items.size()==0) {
							showMessage(request,response,"Cart is empty.");
							return;
						}
						
						days+=stockFactor;
						request.setAttribute("items",items);
						request.setAttribute("days",days);
						request.getRequestDispatcher("/cartPage.jsp")
				        .forward(request, response);
						return;
					}
				}
				showMessage(request,response,"Please enable cookies in your browser.");
				return;
			}else if("ViewOrdersButton".equals(buttonClicked)) {
				for(Cookie cookie:ck) {
					if("username".equals(cookie.getName())) {
						String username = cookie.getValue();
						if("*".equals(username)) {
							showMessage(request,response,"Please log in or create account to view your orders.");
							return;
						}
						ArrayList<Order> orders = new ArrayList<>();
						try {
							getUserIDFromUsername.setString(1, username);
							ResultSet UserID = getUserIDFromUsername.executeQuery();
							if(UserID.next()) {
								int userID = UserID.getInt(1);
								getOrdersFromUserID.setInt(1, userID);
								ResultSet ordersRS = getOrdersFromUserID.executeQuery();
								while(ordersRS.next()) {
									Order order = new Order("",ordersRS.getInt(1), ordersRS.getLong(2), ordersRS.getLong(3), ordersRS.getBoolean(4), false, false, "");
									orders.add(order);
								}
							}
							
							if(orders.size()==0) {
								showMessage(request,response,"No orders yet.");
								return;
							}
							request.setAttribute("orders",orders);
							request.getRequestDispatcher("/orders.jsp")
					        .forward(request, response);
							return;
						}catch(Exception e) {
							e.printStackTrace();
							showMessage(request,response,"Error viewing orders.");
							return;
						}
					}
				}
				showMessage(request,response,"Please enable cookies in your browser.");
				return;
			}else {
				boolean isAdmin = false;
				for(Cookie cookie:ck) {
					if("Admin_name".equals(cookie.getName())) {
						isAdmin = true;
						break;
					}
				}
				int id = Integer.valueOf(buttonClicked);
				try {
					getSubCategoryIDFromCategoryId.setInt(1, id);
					ResultSet sub_ids = getSubCategoryIDFromCategoryId.executeQuery();
					ResultSet descriptionOfCategory;
					boolean noSubcategories = true;
					while(sub_ids.next()) {
						noSubcategories = false;
						int subID  = sub_ids.getInt(1);
						getCategoryDescriptionFromId.setInt(1, subID);
						descriptionOfCategory = getCategoryDescriptionFromId.executeQuery();
						while(descriptionOfCategory.next()) {
							String description = descriptionOfCategory.getString(1);
							categories.add(new CategoryOrProductIdAndTitle(subID,description));
						}
					}
					
					if(noSubcategories) {
						// Show Products
						getProductIDFromCategoryId.setInt(1, id);
						ResultSet product_ids = getProductIDFromCategoryId.executeQuery();
						ResultSet titleOfProduct;
						while(product_ids.next()) {
							int productID  = product_ids.getInt(1);
							getProductDescriptionFromId.setInt(1, productID);
							titleOfProduct = getProductDescriptionFromId.executeQuery();
							while(titleOfProduct.next()) {
								String title = titleOfProduct.getString(1);
								products.add(new CategoryOrProductIdAndTitle(productID,title));
							}
						}
					}

					request.setAttribute("categories",categories);
					request.setAttribute("isAdmin",isAdmin);
					request.setAttribute("products",products);
					request.getRequestDispatcher("/productsPage.jsp")
			        .forward(request, response);
					return;
				}catch(Exception e) {
					e.printStackTrace();
					showMessage(request,response,"Error viewing categories and products.");
					return;
				}
			}
		}else if((buttonClicked = request.getParameter("buttonProduct"))!=null){
			int productID = Integer.valueOf(buttonClicked);
			for(Cookie cookie:ck) {
				if("Admin_name".equals(cookie.getName())) {
					try {
						String productName = "";
						getProductDescriptionFromId.setInt(1, productID);
						ResultSet rs = getProductDescriptionFromId.executeQuery();
						if(rs.next()) {
							productName = rs.getString(1);
						}
						
						getQuantityAndOrderedTimeGivenAProduct.setInt(1, productID);
						ResultSet QNT = getQuantityAndOrderedTimeGivenAProduct.executeQuery();
						ArrayList<String> months = new ArrayList<>();
						ArrayList<Integer> quantity = new ArrayList<>();
						
						while(QNT.next()) {
							SimpleDateFormat month = new SimpleDateFormat("MM/yyyy");
							String monthString = month.format(new Date(QNT.getLong(2)));
							int index = months.indexOf(monthString);
							if(index==-1) {
								months.add(monthString);
								quantity.add(QNT.getInt(1));
							}else {
								quantity.set(index, quantity.get(index)+QNT.getInt(1));
							}
						}
						
						request.setAttribute("productName",productName);
						request.setAttribute("months",months);
						request.setAttribute("quantity",quantity);
						request.getRequestDispatcher("/mostSalesTimePeriodForAProduct.jsp")
				        .forward(request, response);
						return;
					}catch(Exception e) {
						e.printStackTrace();
						showMessage(request,response,"Error viewing the time period of most sales for this product.");
						return;
					}
				}
			}
            Product product = null;
            ArrayList<Variant> variants = new ArrayList<>();
            try {
				ArrayList<AttributeNameAndValue> customAttributesOfProduct = new ArrayList<>();
				getAttributesFromProductID.setInt(1, productID);
				ResultSet attributesProduct;
				attributesProduct = getAttributesFromProductID.executeQuery();
				while(attributesProduct.next()) {
					customAttributesOfProduct.add(new AttributeNameAndValue(attributesProduct.getString(1),attributesProduct.getString(2)));
				}
				getProductDataFromId.setInt(1, productID);
				ResultSet dataOfProduct;
				dataOfProduct = getProductDataFromId.executeQuery();
				while(dataOfProduct.next()) {
					product = new Product(dataOfProduct.getString(1), dataOfProduct.getInt(2), customAttributesOfProduct);
				}

				getVariantDataFromProductID.setInt(1, productID);
				ResultSet variantsFromProductID = getVariantDataFromProductID.executeQuery();
				while(variantsFromProductID.next()) {
					int variantId = variantsFromProductID.getInt(1);
					getAttributesFromVariantID.setInt(1, variantId);
					ResultSet attributesFromVariantID = getAttributesFromVariantID.executeQuery();
					ArrayList<AttributeNameAndValue> attributesOfVariant = new ArrayList<>();
					while(attributesFromVariantID.next()) {
						attributesOfVariant.add(new AttributeNameAndValue(attributesFromVariantID.getString(1),attributesFromVariantID.getString(2)));
					}
					int quantityAvailable = variantsFromProductID.getInt(3);
					if(quantityAvailable<0) {quantityAvailable=0;}
					variants.add(new Variant(variantId,variantsFromProductID.getInt(2),quantityAvailable,variantsFromProductID.getString(4),attributesOfVariant));
				}
            }catch(Exception e){
            	e.printStackTrace();
            }

    		request.setAttribute("product",product);
    		request.setAttribute("variants",variants);
			request.getRequestDispatcher("/variantsPage.jsp")
	        .forward(request, response);
			return;
		}else if((buttonClicked = request.getParameter("AddToCartButton"))!=null){
			int variantID = Integer.valueOf(buttonClicked);
			for(Cookie c:ck) {
				if("username".equals(c.getName())) {
					String username = c.getValue();
					if("*".equals(username)) {
						showMessage(request,response,"Please log in or create account to add items to cart.");
						return;
					}
					
					String quantity = request.getParameter("quantityToBeOrdered");
					if(quantity==null || "".equals(quantity)) {
						showMessage(request,response,"Please select a quantity.");
						return;
					}
					
					int quantityToBeAdded = Integer.valueOf(quantity);
					try {
						getUserIDFromUsername.setString(1, username);
						ResultSet UserID = getUserIDFromUsername.executeQuery();
						if(UserID.next()) {
							int uID = UserID.getInt(1);
							getCartNOFromUserID.setInt(1, uID);
							ResultSet CartNO = getCartNOFromUserID.executeQuery();
							if(CartNO.next()) {
								int cartno = CartNO.getInt(1);
								getQuantityFromItemForUserIDCartNoAndVariantId.setInt(1, uID);
								getQuantityFromItemForUserIDCartNoAndVariantId.setInt(2, cartno);
								getQuantityFromItemForUserIDCartNoAndVariantId.setInt(3, variantID);
								ResultSet r = getQuantityFromItemForUserIDCartNoAndVariantId.executeQuery();
								if(r.next()) {
									updateItemQuantity.setInt(1, quantityToBeAdded);
									updateItemQuantity.setInt(2, uID);
									updateItemQuantity.setInt(3, cartno);
									updateItemQuantity.setInt(4, variantID);
									updateItemQuantity.executeUpdate();
								}else {
									addToCart.setInt(1, uID);
									addToCart.setInt(2, cartno);
									addToCart.setInt(3, quantityToBeAdded);
									addToCart.setInt(4, variantID);
									addToCart.executeUpdate();
								}
								
								/*updateVariantQuantityAvailable.setInt(1, (-1)*quantityToBeAdded);
								updateVariantQuantityAvailable.setInt(2, variantID);
								updateVariantQuantityAvailable.executeUpdate();*/
							}
							
						}
						showMessage(request,response,"Successfully added to cart.");
						return;
					}catch(Exception e) {
						e.printStackTrace();
						showMessage(request,response,"Error adding to cart.");
						return;
					}
					
				}
			}
			showMessage(request,response,"Please enable cookies in your browser.");
			return;
		}else if((buttonClicked = request.getParameter("RemoveFromCartButton"))!=null){
			for(Cookie c:ck) {
				if("username".equals(c.getName())) {
					String username = c.getValue();
					if("*".equals(username)) {
						showMessage(request,response,"Please log in or create account to add items to cart.");
						return;
					}
					
					try {
						getUserIDFromUsername.setString(1, username);
						ResultSet UserID = getUserIDFromUsername.executeQuery();
						if(UserID.next()) {
							int uID = UserID.getInt(1);
							getCartNOFromUserID.setInt(1, uID);
							ResultSet CartNO = getCartNOFromUserID.executeQuery();
							if(CartNO.next()) {
								int cartno = CartNO.getInt(1);
								int variantID = Integer.valueOf(buttonClicked);
								getQuantityFromItemForUserIDCartNoAndVariantId.setInt(1, uID);
								getQuantityFromItemForUserIDCartNoAndVariantId.setInt(2, cartno);
								getQuantityFromItemForUserIDCartNoAndVariantId.setInt(3, variantID);
								ResultSet r = getQuantityFromItemForUserIDCartNoAndVariantId.executeQuery();
								if(r.next()) {
									removeItemFromCart.setInt(1, uID);
									removeItemFromCart.setInt(2, cartno);
									removeItemFromCart.setInt(3, variantID);
									removeItemFromCart.executeUpdate();

									/*updateVariantQuantityAvailable.setInt(1, r.getInt(1));
									updateVariantQuantityAvailable.setInt(2, variantID);
									updateVariantQuantityAvailable.executeUpdate();*/
								}
							}
						}
						showMessage(request,response,"Successfully removed from cart.");
						return;
					}catch(Exception e) {
						e.printStackTrace();
						showMessage(request,response,"Error removing from cart.");
						return;
					}
				}
			}
			showMessage(request,response,"Please enable cookies in your browser.");
			return;
		}else if((buttonClicked = request.getParameter("CheckoutButton"))!=null) {
			for(Cookie c:ck) {
				if("username".equals(c.getName())) {
					String username = c.getValue();
					if("*".equals(username)) {
						showMessage(request,response,"Please log in or create account to checkout.");
						return;
					}
					
					try {
						getUserIDFromUsername.setString(1, username);
						ResultSet UserID = getUserIDFromUsername.executeQuery();
						if(UserID.next()) {
							int uID = UserID.getInt(1);
							boolean isStorePickup = "StorePickupSelected".equals(request.getParameter("deliveryMethod"));
							boolean paidByCard = "PayByCardSelected".equals(request.getParameter("paymentMethod"));
							getCartNOFromUserID.setInt(1, uID);
							ResultSet CartNO = getCartNOFromUserID.executeQuery();
							if(CartNO.next()) {
								int cartno = CartNO.getInt(1);
								int days = Integer.valueOf(buttonClicked);
								
								getItemDataFromUserIDAndCartNo.setInt(1, uID);
								getItemDataFromUserIDAndCartNo.setInt(2, cartno);
								ResultSet variantsAndQuantities = getItemDataFromUserIDAndCartNo.executeQuery();
								try {
										
									con.setAutoCommit(false);
									
									while(variantsAndQuantities.next()) {
										int quantityOrdered = variantsAndQuantities.getInt(1);
										int varID = variantsAndQuantities.getInt(2);
										updateVariantQuantityAvailable.setInt(1, (-1)*quantityOrdered);
										updateVariantQuantityAvailable.setInt(2, varID);
										updateVariantQuantityAvailable.executeUpdate();
									}
									
									long orderedTime = System.currentTimeMillis();
									long expectedTime = orderedTime + 86400000*days;	//86400000 is the number of milliseconds in a day.
									
									checkout.setInt(1, uID);
									checkout.setInt(2, cartno);
									checkout.setLong(3,orderedTime);
									checkout.setLong(4,expectedTime);
									checkout.setBoolean(5, false);
									checkout.setBoolean(6, isStorePickup);
									checkout.setBoolean(7, paidByCard);
									checkout.setString(8, "");
									checkout.executeUpdate();
									
									incrementCartNo.setInt(1, uID);
									incrementCartNo.executeUpdate();
									
									con.commit();
									con.setAutoCommit(true);
								}catch(Exception e) {

									con.rollback();
									con.setAutoCommit(true);
									e.printStackTrace();
									showMessage(request,response,"Error at checkout.");
									return;
								}
							}
						}
						showMessage(request,response,"Checkout Successful!");
						return;
					}catch(Exception e) {
						e.printStackTrace();
						showMessage(request,response,"Error at checkout.");
						return;
					}
				}
			}
			showMessage(request,response,"Please enable cookies in your browser.");
			return;
		}else if((buttonClicked = request.getParameter("ViewOrderButton"))!=null) {
			for(Cookie cookie:ck) {
				if("username".equals(cookie.getName())) {
					String username = cookie.getValue();
					if("*".equals(username)) {
						showMessage(request,response,"Please log in or create account to view your order.");
						return;
					}
					ArrayList<Item> items = new ArrayList<>();
					Order order = null;

					try {
						getUserIDFromUsername.setString(1, username);
						ResultSet UserID = getUserIDFromUsername.executeQuery();
						if(UserID.next()) {
							int uID = UserID.getInt(1);
							int cartno = Integer.valueOf(buttonClicked);

							getOrderFromUserIDAndCartNo.setInt(1, uID);
							getOrderFromUserIDAndCartNo.setInt(2, cartno);
							ResultSet orderRS = getOrderFromUserIDAndCartNo.executeQuery();
							if(orderRS.next()) {
								order = new Order("",cartno, orderRS.getLong(1), orderRS.getLong(2), 
										orderRS.getBoolean(3), orderRS.getBoolean(4), orderRS.getBoolean(5), orderRS.getString(6));
							}
							
							getItemDataFromUserIDAndCartNo.setInt(1, uID);
							getItemDataFromUserIDAndCartNo.setInt(2, cartno);
							ResultSet variantsAndQuantities = getItemDataFromUserIDAndCartNo.executeQuery();
							while(variantsAndQuantities.next()) {
								Item item;
								int quantityOrdered = variantsAndQuantities.getInt(1);
								int varID = variantsAndQuantities.getInt(2);
								getVariantDataFromVariantID.setInt(1, varID);
								ResultSet vardata = getVariantDataFromVariantID.executeQuery();
								if(vardata.next()) {
									int productID = vardata.getInt(1);
									int price = vardata.getInt(2);
									int quantityAvailable = vardata.getInt(3);
									String imagePath = vardata.getString(4);
									ArrayList<AttributeNameAndValue> AttributesOfVariant = new ArrayList<>();
									getAttributesFromVariantID.setInt(1, varID);
									ResultSet varAttr = getAttributesFromVariantID.executeQuery();
									while(varAttr.next()) {
										AttributesOfVariant.add(new AttributeNameAndValue(varAttr.getString(1),varAttr.getString(2)));
									}
									Variant variant = new Variant(varID,price,quantityAvailable,imagePath,AttributesOfVariant);

									getProductDataFromId.setInt(1, productID);
									ResultSet productdata = getProductDataFromId.executeQuery();
									if(productdata.next()) {
										String productTitle = productdata.getString(1);
										int productWeight = productdata.getInt(2);
										ArrayList<AttributeNameAndValue> AttributesOfProduct = new ArrayList<>();
										getAttributesFromProductID.setInt(1, productID);
										ResultSet productAttr = getAttributesFromProductID.executeQuery();
										while(productAttr.next()) {
											AttributesOfProduct.add(new AttributeNameAndValue(productAttr.getString(1),productAttr.getString(2)));
										}
										Product product = new Product(productTitle,productWeight,AttributesOfProduct);
										item = new Item(quantityOrdered, product, variant);
										items.add(item);
									}
								}
							}
						}
					}catch(Exception e) {
						e.printStackTrace();
						showMessage(request,response,"Error viewing order.");
						return;
					}
					
					if(items.size()==0 || order==null) {
						showMessage(request,response,"Order is empty.");
						return;
					}
					
					request.setAttribute("items",items);
					request.setAttribute("order",order);
					request.getRequestDispatcher("/specificOrder.jsp")
			        .forward(request, response);
					return;
				}
			}
			showMessage(request,response,"Please enable cookies in your browser.");
			return;
		}else if((buttonClicked = request.getParameter("SetAsCompleted"))!=null) {
			for(Cookie cookie:ck) {
				if("username".equals(cookie.getName())) {
					String username = cookie.getValue();
					if("*".equals(username)) {
						showMessage(request,response,"Please log in or create account to view your cart.");
						return;
					}
					try {
						getUserIDFromUsername.setString(1, username);
						ResultSet UserID = getUserIDFromUsername.executeQuery();
						if(UserID.next()) {
							int uID = UserID.getInt(1);
							int cartno = Integer.valueOf(buttonClicked);
							setOrderAsCompleted.setInt(1, uID);
							setOrderAsCompleted.setInt(2, cartno);
							setOrderAsCompleted.executeUpdate();
						}
						showMessage(request,response,"Order status updated successfully.");
						return;
					}catch(Exception e) {
						e.printStackTrace();
						showMessage(request,response,"Error updating order status.");
						return;
					}
				}
			}
			showMessage(request,response,"Please enable cookies in your browser.");
			return;
		}else if((buttonClicked = request.getParameter("SubmitOrEditFeedback"))!=null) {
			for(Cookie cookie:ck) {
				if("username".equals(cookie.getName())) {
					String username = cookie.getValue();
					if("*".equals(username)) {
						showMessage(request,response,"Please log in or create account to view your cart.");
						return;
					}
					try {
						getUserIDFromUsername.setString(1, username);
						ResultSet UserID = getUserIDFromUsername.executeQuery();
						if(UserID.next()) {
							int uID = UserID.getInt(1);
							int cartno = Integer.valueOf(buttonClicked);
							String feedback = "";
							getFeedbackFromUserIDAndCartNo.setInt(1, uID);
							getFeedbackFromUserIDAndCartNo.setInt(2, cartno);
							ResultSet orderFeedbackRS = getFeedbackFromUserIDAndCartNo.executeQuery();
							if(orderFeedbackRS.next()) {
								feedback = orderFeedbackRS.getString(1);
							}

							request.setAttribute("cartNo",cartno);
							request.setAttribute("feedback",feedback);
							request.getRequestDispatcher("/feedbackForm.jsp")
					        .forward(request, response);
							return;
						}
						showMessage(request,response,"Error loading feedback form.");
						return;
					}catch(Exception e) {
						e.printStackTrace();
						showMessage(request,response,"Error loading feedback form.");
						return;
					}
				}
			}
			showMessage(request,response,"Please enable cookies in your browser.");
			return;
		}else if((buttonClicked = request.getParameter("SubmitFeedback"))!=null) {
			for(Cookie cookie:ck) {
				if("username".equals(cookie.getName())) {
					String username = cookie.getValue();
					if("*".equals(username)) {
						showMessage(request,response,"Please log in or create account to view your cart.");
						return;
					}
					try {
						getUserIDFromUsername.setString(1, username);
						ResultSet UserID = getUserIDFromUsername.executeQuery();
						if(UserID.next()) {
							int uID = UserID.getInt(1);
							int cartno = Integer.valueOf(buttonClicked);
							String feedback = request.getParameter("feedback");
							if(feedback!=null) {
								if(feedback.length()<=1000) {
									setFeedbackFromUserIDAndCartNo.setString(1, feedback);
									setFeedbackFromUserIDAndCartNo.setInt(2, uID);
									setFeedbackFromUserIDAndCartNo.setInt(3, cartno);
									setFeedbackFromUserIDAndCartNo.executeUpdate();
		
									showMessage(request,response,"Feedback submitted successfully.");
									return;
								}else {
									showMessage(request,response,"Feedback can have a maximum of 1000 characters only.");
									return;
								}
							}
						}
						showMessage(request,response,"Error submitting feedback.");
						return;
					}catch(Exception e) {
						showMessage(request,response,"Error submitting feedback.");
						e.printStackTrace();
						return;
					}
				}
			}
			showMessage(request,response,"Please enable cookies in your browser.");
			return;
		}else if((buttonClicked = request.getParameter("AdminViewAllOrders"))!=null) {
			ArrayList<Order> orders = new ArrayList<>();
			try {
				ResultSet ordersRS = getAllOrders.executeQuery();
				while(ordersRS.next()) {
					int uID = ordersRS.getInt(1);
					getUsernameFromUserId.setInt(1,uID);
					ResultSet UsernameRS = getUsernameFromUserId.executeQuery();
					if(UsernameRS.next()) {
						Order order = new Order(UsernameRS.getString(1),ordersRS.getInt(2), ordersRS.getLong(3), ordersRS.getLong(4),
								ordersRS.getBoolean(5), ordersRS.getBoolean(6), ordersRS.getBoolean(7), ordersRS.getString(8));
						orders.add(order);
					}
				}
				
				if(orders.size()==0) {
					showMessage(request,response,"No orders yet.");
					return;
				}
				request.setAttribute("orders",orders);
				request.getRequestDispatcher("/adminViewAllOrders.jsp")
		        .forward(request, response);
				return;
			}catch(Exception e) {
				showMessage(request,response,"Error viewing orders.");
				e.printStackTrace();
				return;
			}

		}else if((buttonClicked = request.getParameter("AdminViewSpecificOrder"))!=null) {
			int indexOfDash = buttonClicked.indexOf("-");
			String username = buttonClicked.substring(0,indexOfDash);
			int cartno = Integer.valueOf(buttonClicked.substring(indexOfDash+1));
			ArrayList<Item> items = new ArrayList<>();
			Order order = null;

			try {
				getUserIDFromUsername.setString(1, username);
				ResultSet UserID = getUserIDFromUsername.executeQuery();
				if(UserID.next()) {
					int uID = UserID.getInt(1);

					getOrderFromUserIDAndCartNo.setInt(1, uID);
					getOrderFromUserIDAndCartNo.setInt(2, cartno);
					ResultSet orderRS = getOrderFromUserIDAndCartNo.executeQuery();
					if(orderRS.next()) {
						order = new Order(username,cartno, orderRS.getLong(1), orderRS.getLong(2), 
								orderRS.getBoolean(3), orderRS.getBoolean(4), orderRS.getBoolean(5), orderRS.getString(6));
					}
					
					getItemDataFromUserIDAndCartNo.setInt(1, uID);
					getItemDataFromUserIDAndCartNo.setInt(2, cartno);
					ResultSet variantsAndQuantities = getItemDataFromUserIDAndCartNo.executeQuery();
					while(variantsAndQuantities.next()) {
						Item item;
						int quantityOrdered = variantsAndQuantities.getInt(1);
						int varID = variantsAndQuantities.getInt(2);
						getVariantDataFromVariantID.setInt(1, varID);
						ResultSet vardata = getVariantDataFromVariantID.executeQuery();
						if(vardata.next()) {
							int productID = vardata.getInt(1);
							int price = vardata.getInt(2);
							int quantityAvailable = vardata.getInt(3);
							String imagePath = vardata.getString(4);
							ArrayList<AttributeNameAndValue> AttributesOfVariant = new ArrayList<>();
							getAttributesFromVariantID.setInt(1, varID);
							ResultSet varAttr = getAttributesFromVariantID.executeQuery();
							while(varAttr.next()) {
								AttributesOfVariant.add(new AttributeNameAndValue(varAttr.getString(1),varAttr.getString(2)));
							}
							Variant variant = new Variant(varID,price,quantityAvailable,imagePath,AttributesOfVariant);

							getProductDataFromId.setInt(1, productID);
							ResultSet productdata = getProductDataFromId.executeQuery();
							if(productdata.next()) {
								String productTitle = productdata.getString(1);
								int productWeight = productdata.getInt(2);
								ArrayList<AttributeNameAndValue> AttributesOfProduct = new ArrayList<>();
								getAttributesFromProductID.setInt(1, productID);
								ResultSet productAttr = getAttributesFromProductID.executeQuery();
								while(productAttr.next()) {
									AttributesOfProduct.add(new AttributeNameAndValue(productAttr.getString(1),productAttr.getString(2)));
								}
								Product product = new Product(productTitle,productWeight,AttributesOfProduct);
								item = new Item(quantityOrdered, product, variant);
								items.add(item);
							}
						}
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
				showMessage(request,response,"Error viewing order.");
				return;
			}
			
			if(items.size()==0 || order==null) {
				showMessage(request,response,"Order is empty.");
				return;
			}
			
			request.setAttribute("items",items);
			request.setAttribute("order",order);
			request.getRequestDispatcher("/adminViewSpecificOrder.jsp")
	        .forward(request, response);
			return;
		}else if((buttonClicked = request.getParameter("AdminViewCategorySales"))!=null) {
			
			ArrayList<CategoryQuantityPair> categoryQuantities = new ArrayList<>();
			try {
				ResultSet totalQuantityAndCategoryID = getTotalQuantityForCategories.executeQuery();
				while(totalQuantityAndCategoryID.next()) {
					int id = totalQuantityAndCategoryID.getInt(1);
					int subCatID = id;
					String path = null;
					getCategoryDescriptionFromId.setInt(1, id);
					ResultSet des = getCategoryDescriptionFromId.executeQuery();
					if(des.next()) {
						path = des.getString(1);
					}
					
					ResultSet supCat = null;
					getSuperCategoryID.setInt(1, id);
					while((supCat = getSuperCategoryID.executeQuery()).next()) {
						id = supCat.getInt(1);
						getCategoryDescriptionFromId.setInt(1, id);
						des = getCategoryDescriptionFromId.executeQuery();
						if(des.next()) {
							path = des.getString(1) + "->" + path;
						}
						getSuperCategoryID.setInt(1, id);
					}
					categoryQuantities.add(new CategoryQuantityPair(subCatID, path, totalQuantityAndCategoryID.getInt(2)));
				}
			}catch(Exception e) {
				e.printStackTrace();
				showMessage(request,response,"Error viewing product orders.");
				return;
			}
			
			categoryQuantities.sort(new Comparator<CategoryQuantityPair>() {
                @Override
                public int compare(CategoryQuantityPair qunatityObj, CategoryQuantityPair t1) {
                    return Integer.compare(t1.quantity, qunatityObj.quantity);
                }
            });
			
			request.setAttribute("categoryQuantities",categoryQuantities);
			request.getRequestDispatcher("/categoryOrdersTable.jsp")
	        .forward(request, response);
			return;
			
		}else if((buttonClicked = request.getParameter("AdminViewProductSalesTimePeriod"))!=null) {
			request.getRequestDispatcher("/timePeriodForProductSales.html")
	        .forward(request, response);
			return;
		}else if((buttonClicked = request.getParameter("SubmitTimePeriodForProductSales"))!=null) {
			
			ArrayList<ProductQuantity> productQuantities = new ArrayList<>();
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
				Date date = sdf.parse((String)request.getParameter("from"));
				long from = date.getTime();
				date = sdf.parse((String)request.getParameter("to"));
				long to = date.getTime();
				getTotalQuantityForProductsWithTimePeriod.setLong(1, from);
				getTotalQuantityForProductsWithTimePeriod.setLong(2, to);
				ResultSet ProductAndQuantity = getTotalQuantityForProductsWithTimePeriod.executeQuery();
				while(ProductAndQuantity.next()) {
					productQuantities.add(new ProductQuantity(ProductAndQuantity.getInt(1),ProductAndQuantity.getString(2),ProductAndQuantity.getInt(3)));
				}
			}catch(Exception e) {
				e.printStackTrace();
				showMessage(request,response,"Error viewing product orders.");
				return;
			}
			
			productQuantities.sort(new Comparator<ProductQuantity>() {
                @Override
                public int compare(ProductQuantity qunatityObj, ProductQuantity t1) {
                    return Integer.compare(t1.quantity, qunatityObj.quantity);
                }
            });
			
			request.setAttribute("productQuantities",productQuantities);
			request.getRequestDispatcher("/productOrdersTable.jsp")
	        .forward(request, response);
			return;
		}else if((buttonClicked = request.getParameter("AdminTimePeriodWithMostOrdersOnAProduct"))!=null) {
			goingToHomePage(categories);
			request.setAttribute("categories",categories);
			request.setAttribute("isAdmin",true);
	        request.getRequestDispatcher("/productsPage.jsp")
	        .forward(request, response);
			return;
		}else if((buttonClicked = request.getParameter("AdminViewSalesReport"))!=null) {
			request.getRequestDispatcher("/timePeriodForSalesReport.html")
	        .forward(request, response);
			return;
		}else if((buttonClicked = request.getParameter("SubmitTimePeriodForSalesReport"))!=null) {
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
				Date date = sdf.parse((String)request.getParameter("from"));
				long from = date.getTime();
				date = sdf.parse((String)request.getParameter("to"));
				long to = date.getTime();
				getUserIDAndCartNOFromTimePeriod.setLong(1, from);
				getUserIDAndCartNOFromTimePeriod.setLong(2, to);
				ResultSet UIDNCRTNO = getUserIDAndCartNOFromTimePeriod.executeQuery();
				int noOfOrders = 0;
				int noOfItemsSold = 0;
				int revenue = 0;
				while(UIDNCRTNO.next()) {
					++noOfOrders;
					getItemDataFromUserIDAndCartNO.setLong(1, UIDNCRTNO.getInt(1));
					getItemDataFromUserIDAndCartNO.setLong(2, UIDNCRTNO.getInt(2));
					ResultSet QuantityAndVariantID = getItemDataFromUserIDAndCartNO.executeQuery();
					while(QuantityAndVariantID.next()) {
						int quantity = QuantityAndVariantID.getInt(1);
						noOfItemsSold+=quantity;
						getVariantPriceFromVariantID.setInt(1, QuantityAndVariantID.getInt(2));
						ResultSet PriceOfVariant = getVariantPriceFromVariantID.executeQuery();
						if(PriceOfVariant.next()) {
							revenue += quantity*PriceOfVariant.getInt(1);
						}
					}
				}
				request.setAttribute("noOfOrders",noOfOrders);
				request.setAttribute("noOfItemsSold",noOfItemsSold);
				request.setAttribute("revenue",revenue);
				request.getRequestDispatcher("/SalesReport.jsp")
		        .forward(request, response);
				return;
			}catch(Exception e) {
				e.printStackTrace();
				showMessage(request,response,"Error viewing sales report.");
				return;
			}
		}

		request.setAttribute("categories",categories);
		request.setAttribute("products",products);
		request.getRequestDispatcher("/productsPage.jsp")
        .forward(request, response);
		return;
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public String validateUsername(String username) {
		String message = "";
		if("".equals(username)) {
			message = "Username cannot be empty.";
		}else if(username.length()>20){
			message = "Username can only have a maximum of 20 characters.";
		}else {
			char[] ch = username.toCharArray();
	        for (int i = 0; i < ch.length; i++) {
	            if(alphabetAndNumbersAndUnderscore.indexOf(ch[i])==-1) {
	            	message = "Username can contain only characters from the English alphabet, digits and underscore.";
	            	break;
	            }
	        }
		}
		return message;
	}
	
	public String validatePassword(String pass, String repass) {
		String message = "";
		if("".equals(pass)) {
			message = "Password cannot be empty.";
		}else if(pass.length()>12){
			message = "Password can only have a maximum of 12 characters.";
		}else if(!pass.equals(repass)) {
			message = "Passwords do not match.";
		}else {
	        char[] ch = pass.toCharArray();
	        for (int i = 0; i < ch.length; i++) {
	            if(alphabetAndNumbersAndUnderscore.indexOf(ch[i])==-1) {
	            	message = "Password can contain only characters from the English alphabet, digits and underscore.";
	            	break;
	            }
	        }
		}
		return message;
	}
	
	public String validatePhone(String phone) {
		String message = "";
		if(!phone.startsWith("0")) {
			message = "Phone number should start with 0.";
        }else if(phone.length()!=10) {
        	message = "Phone number should contain 10 digits.";
        }else {
	        char[] ch = phone.toCharArray();
	        for (int i = 0; i < ch.length; i++) {
	            if(digits.indexOf(ch[i])==-1) {
	            	message = "Phone number must only contain digits.";
	            }
	        }
        }
		return message;
	}
	
	public void goingToHomePage(ArrayList<CategoryOrProductIdAndTitle> array) {
		array.add(new CategoryOrProductIdAndTitle(10,"Electronics"));
		array.add(new CategoryOrProductIdAndTitle(11,"Toys"));
	}
	
	public void clearCookies(Cookie[] cookies,HttpServletResponse response) {
		if(cookies!=null) {
			for(Cookie c:cookies) {
				c.setMaxAge(0);
			    c.setValue(null);
				response.addCookie(c);
			}
		}
	}
	
	public void showMessage(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException{
		request.setAttribute("error",message);
		request.getRequestDispatcher("/Error Page.jsp")
        .forward(request, response);
		return;
	}
}
