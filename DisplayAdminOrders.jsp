<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-left:40%
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <table>
        <tr>
            <th>Product Name</th>
            <th>Price</th>
        </tr>
        <% 
            // Database connection parameters
            String DB_URL = "jdbc:mysql://localhost:3306/online_grocery_shopping";
            String DB_USERNAME = "root";
            String DB_PASSWORD = "mysql";

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                // Connect to the database
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

                // SQL query to select data from admin_orders table
                String selectSql = "SELECT * FROM admin_orders";
                stmt = conn.prepareStatement(selectSql);
                rs = stmt.executeQuery();

                // Iterate through the result set and display data
                while (rs.next()) {
                    String productName = rs.getString("productName");
                    double price = rs.getDouble("price");
        %>
            <tr>
                <td><%= productName %></td>
                <td><%= price %></td>
            </tr>
        <% 
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close JDBC objects
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </table>
    <br>
    <button onclick="markOrderFinished()">Order Finished</button>

    <script>
        function markOrderFinished() {
            if (confirm("Are you sure you want to mark the order as finished?")) {
                // Send AJAX request to delete all items from admin_orders table
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "delete_orders.jsp", true);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        alert("Order marked as finished!");
                        // Reload the page to update the displayed orders
                        location.reload();
                    }
                };
                xhr.send();
            }
        }
    </script>
</body>
</html>
