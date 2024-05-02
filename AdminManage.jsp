<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Orders</title>
</head>
 <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
        }

        .error {
            color: red;
            text-align: center;
        }

        .success {
            color: green;
            text-align: center;
        }

        a {
            display: block;
            text-align: center;
            margin-bottom: 20px;
            text-decoration: none;
            color: #007bff;
        }

        a:hover {
            color: #0056b3;
        }
       </style>
<body>
<div class="container">
        <h1>Admin Orders</h1>
        <a href="DisplayAdminOrders.jsp">View Orders</a>
</div>        
    <%
        // Database connection parameters
        String DB_URL = "jdbc:mysql://localhost:3306/online_grocery_shopping";
        String DB_USERNAME = "root";
        String DB_PASSWORD = "mysql";
        
        Connection conn = null;
        PreparedStatement selectStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;
        
        try {
            // Connect to the database
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
            
            // SQL query to select data from ordered_items table
            String selectSql = "SELECT * FROM ordered_items";
            selectStmt = conn.prepareStatement(selectSql);
            rs = selectStmt.executeQuery();
            
            // SQL query to insert data into admin_orders table
            String insertSql = "INSERT INTO admin_orders (productName, price) VALUES (?, ?)";
            insertStmt = conn.prepareStatement(insertSql);
            
            // Iterate through the result set and insert data into admin_orders table
            while (rs.next()) {
                String productName = rs.getString("productName");
                double price = rs.getDouble("price");
                
                // Set parameters for the insert statement
                insertStmt.setString(1, productName);
                insertStmt.setDouble(2, price);
                
                // Execute the insert statement
                insertStmt.executeUpdate();
            }
            
            // Print success message
            out.println("<h1>Admin Orders Table Updated Successfully!</h1>");
            
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
        } finally {
            // Close JDBC objects
            if (rs != null) rs.close();
            if (selectStmt != null) selectStmt.close();
            if (insertStmt != null) insertStmt.close();
            if (conn != null) conn.close();
        }
    %>
</body>
</html>
