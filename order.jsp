<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MY ORDERS</title>
</head>
	<style>
		body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 20px;
}

h1 {
    text-align: center;
}

.cart-item {
    background-color: #fff;
    border: 1px solid #ccc;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
}

.cart-item p {
    margin: 5px 0;
}

h2 {
    text-align: center;
    color: #888;
}
		
	</style>
<body>

    <h1>Order Details</h1>
    <%
        // Retrieve data from the ordered_items table
        String orderUrl = "jdbc:mysql://localhost:3306/online_grocery_shopping";
        String orderUsername = "root";
        String orderPassword = "mysql";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection orderConn = DriverManager.getConnection(orderUrl, orderUsername, orderPassword);

            String orderSql = "SELECT * FROM ordered_items";
            PreparedStatement orderStmt = orderConn.prepareStatement(orderSql);
            ResultSet orderRs = orderStmt.executeQuery();

            // Check if there are any orders
            boolean hasOrders = false;
            while (orderRs.next()) {
                hasOrders = true;
                String productName = orderRs.getString("productName");
                double price = orderRs.getDouble("price");
    %>
                <div class="cart-item">
                    <p><strong>Product Name:</strong> <%= productName %></p>
                    <p><strong>Price:</strong> <%= price %></p>
                </div>
    <%
            }
            orderRs.close();
            orderStmt.close();
            orderConn.close();

            if (!hasOrders) {
    %>
                <h2>No Orders Yet</h2>
    <%
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.print("Error retrieving data from ordered_items table: " + e.getMessage());
        }
    %>

</body>
</html>
