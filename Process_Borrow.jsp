<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Process Borrow Request</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="top-division">
        <nav>
            <a href="index.html">Home</a>
            <a href="books.jsp">Available Books</a>
            <a href="borrow.html">Borrow</a>
        </nav>
    </div>

    <div class="information-division">
        <h1>Borrow Request Processing</h1>
        <div class="content">
<%
    /**
     * EXPLANATION OF PROCESS_BORROW.JSP LOGIC:
     * 
     * 1. RETRIEVING FORM DATA:
     *    - Use request.getParameter() to retrieve form data submitted from borrow.html
     *    - Each form field is retrieved by its name attribute
     */
    
    // Retrieve form data
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String bookIdStr = request.getParameter("bookId");
    String borrowDate = request.getParameter("borrowDate");
    
    // Convert bookId to integer
    int bookId = 0;
    try {
        bookId = Integer.parseInt(bookIdStr);
    } catch (NumberFormatException e) {
        out.println("<p style='color: red;'>Invalid Book ID format.</p>");
        return;
    }
    
    /**
     * 2. DATABASE CONNECTION:
     *    - Load the JDBC driver
     *    - Establish connection using DriverManager
     *    - Use same credentials as in books.jsp
     */
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    boolean success = false;
    String message = "";
    
    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        // Database connection details
        String dbURL = "jdbc:mysql://localhost:3306/library_db";
        String dbUser = "root";
        String dbPassword = "your_password"; // Update with actual password
        
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        
        /**
         * 3. CHECK IF BOOK EXISTS AND IS AVAILABLE:
         *    - First verify the book exists and has 'Available' status
         *    - This prevents updating books that don't exist or are already borrowed
         */
        
        String checkSQL = "SELECT Status FROM books WHERE BookID = ?";
        pstmt = conn.prepareStatement(checkSQL);
        pstmt.setInt(1, bookId);
        rs = pstmt.executeQuery();
        
        if (rs.next()) {
            String currentStatus = rs.getString("Status");
            
            if ("Available".equalsIgnoreCase(currentStatus)) {
                /**
                 * 4. UPDATE THE BOOK STATUS:
                 *    - Use UPDATE SQL statement to change status from 'Available' to 'Borrowed'
                 *    - Use PreparedStatement to prevent SQL injection
                 */
                
                // Close previous statement
                rs.close();
                pstmt.close();
                
                String updateSQL = "UPDATE books SET Status = 'Borrowed' WHERE BookID = ?";
                pstmt = conn.prepareStatement(updateSQL);
                pstmt.setInt(1, bookId);
                
                int rowsAffected = pstmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    success = true;
                    message = "Success! Book borrowed successfully.";
                    
                    /**
                     * 5. OPTIONAL - STORE BORROW RECORD:
                     *    - In a complete system, you would also insert a record
                     *      into a 'borrow_records' table with:
                     *      - BorrowID (auto-increment)
                     *      - BookID
                     *      - BorrowerName
                     *      - BorrowerEmail
                     *      - BorrowDate
                     *      - ReturnDate (nullable)
                     */
                    
                    // Example (table would need to be created):
                    // INSERT INTO borrow_records (BookID, BorrowerName, BorrowerEmail, BorrowDate)
                    // VALUES (?, ?, ?, ?)
                    
                } else {
                    message = "Error: Unable to update book status.";
                }
                
            } else {
                message = "Error: This book is already borrowed.";
            }
            
        } else {
            message = "Error: Book ID not found in database.";
        }
        
    } catch (ClassNotFoundException e) {
        message = "Error: MySQL JDBC Driver not found - " + e.getMessage();
    } catch (SQLException e) {
        message = "Database Error: " + e.getMessage();
    } finally {
        /**
         * 6. CLOSE DATABASE RESOURCES:
         *    - Always close ResultSet, Statement, and Connection
         *    - Use finally block to ensure resources are closed even if error occurs
         */
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            message += " Error closing resources: " + e.getMessage();
        }
    }
    
    /**
     * 7. DISPLAY SUCCESS OR FAILURE MESSAGE:
     *    - Show appropriate message to user based on operation result
     *    - Include details of the borrow request
     *    - Provide links to navigate back
     */
    
    if (success) {
%>
        <div style="background-color: #d4edda; border: 1px solid #c3e6cb; padding: 20px; border-radius: 5px; margin: 20px 0;">
            <h2 style="color: #155724;">✓ <%= message %></h2>
            <p><strong>Borrower Name:</strong> <%= fullName %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Book ID:</strong> <%= bookId %></p>
            <p><strong>Borrow Date:</strong> <%= borrowDate %></p>
        </div>
        <p style="text-align: center;">
            <a href="books.jsp" style="margin: 0 10px;">View Available Books</a> | 
            <a href="borrow.html" style="margin: 0 10px;">Borrow Another Book</a> | 
            <a href="index.html" style="margin: 0 10px;">Return to Home</a>
        </p>
<%
    } else {
%>
        <div style="background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 20px; border-radius: 5px; margin: 20px 0;">
            <h2 style="color: #721c24;">✗ <%= message %></h2>
        </div>
        <p style="text-align: center;">
            <a href="borrow.html" style="margin: 0 10px;">Try Again</a> | 
            <a href="books.jsp" style="margin: 0 10px;">View Available Books</a> | 
            <a href="index.html" style="margin: 0 10px;">Return to Home</a>
        </p>
<%
    }
%>
        </div>
    </div>
    
    <!--
    SUMMARY OF LOGIC FLOW:
    
    1. Retrieve form data using request.getParameter()
    2. Connect to database using JDBC
    3. Check if book exists and is available
    4. Update book status from 'Available' to 'Borrowed'
    5. (Optional) Insert borrow record into separate table
    6. Close all database resources properly
    7. Display success or failure message to user
    
    ERROR HANDLING:
    - Invalid Book ID format
    - Book not found in database
    - Book already borrowed
    - Database connection errors
    - SQL execution errors
    
    SECURITY CONSIDERATIONS:
    - Use PreparedStatement to prevent SQL injection
    - Validate all input data
    - Handle exceptions gracefully
    - Close database resources in finally block
    -->
</body>
</html>