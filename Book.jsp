<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Community Library - Available Books</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <!-- Top Division (Header) -->
    <div class="top-division">
        <nav>
            <a href="index.html">Home</a>
            <a href="books.jsp" class="active">Available Books</a>
            <a href="borrow.html">Borrow</a>
        </nav>
    </div>

    <!-- Information Division -->
    <div class="information-division">
        <h1>Available Books</h1>
        
        <div class="content">
            <p style="text-align: center; margin-bottom: 20px;">
                Browse our collection of books below. Note the Book ID if you wish to borrow a book.
            </p>

            <%
                // Database connection variables
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                
                try {
                    // Load MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Establish connection to database
                    // Update the connection string with your database credentials
                    String dbURL = "jdbc:mysql://localhost:3306/library_db";
                    String dbUser = "root";
                    String dbPassword = "your_password"; // Change this to your MySQL password
                    
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                    
                    // Create statement
                    stmt = conn.createStatement();
                    
                    // Execute SQL query to fetch all books
                    String sql = "SELECT BookID, Title, Author, Genre, Status FROM books";
                    rs = stmt.executeQuery(sql);
                    
                    // Display books in HTML table
            %>
                    <table class="books-table">
                        <thead>
                            <tr>
                                <th>Book ID</th>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Genre</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
            <%
                    // Loop through result set and display each book
                    while (rs.next()) {
                        int bookId = rs.getInt("BookID");
                        String title = rs.getString("Title");
                        String author = rs.getString("Author");
                        String genre = rs.getString("Genre");
                        String status = rs.getString("Status");
                        
                        // Determine CSS class based on status
                        String statusClass = "";
                        if ("Available".equalsIgnoreCase(status)) {
                            statusClass = "status-available";
                        } else if ("Borrowed".equalsIgnoreCase(status)) {
                            statusClass = "status-borrowed";
                        }
            %>
                            <tr>
                                <td><%= bookId %></td>
                                <td><%= title %></td>
                                <td><%= author %></td>
                                <td><%= genre %></td>
                                <td class="<%= statusClass %>"><%= status %></td>
                            </tr>
            <%
                    }
            %>
                        </tbody>
                    </table>
            <%
                } catch (ClassNotFoundException e) {
                    out.println("<p style='color: red; text-align: center;'>Error: MySQL JDBC Driver not found.</p>");
                    out.println("<p style='text-align: center;'>" + e.getMessage() + "</p>");
                } catch (SQLException e) {
                    out.println("<p style='color: red; text-align: center;'>Database connection error.</p>");
                    out.println("<p style='text-align: center;'>" + e.getMessage() + "</p>");
                } finally {
                    // Close resources
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<p style='color: red;'>Error closing database resources: " + e.getMessage() + "</p>");
                    }
                }
            %>
            
            <p style="text-align: center; margin-top: 30px;">
                Ready to borrow? Visit our <a href="borrow.html">Borrow page</a> to submit a request!
            </p>
        </div>
    </div>
</body>
</html>