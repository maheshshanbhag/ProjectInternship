<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // Database connection parameters
    String DB_URL = "jdbc:mysql://localhost:3306/online_grocery_shopping";
    String DB_USERNAME = "root";
    String DB_PASSWORD = "mysql";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Connect to the database
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

        // SQL query to delete all items from admin_orders table
        String deleteSql = "DELETE FROM admin_orders";
        stmt = conn.prepareStatement(deleteSql);
        int rowsAffected = stmt.executeUpdate();

        // Print the number of rows deleted (for debugging purposes)
        out.println(rowsAffected + " rows deleted from admin_orders table");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close JDBC objects
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
