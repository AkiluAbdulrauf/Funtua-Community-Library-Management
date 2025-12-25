# Community Library Management Website
## BCSL-057 Web Programming Lab Assignment

### Project Overview
A dynamic web application for managing a community library, allowing users to browse available books and submit borrow requests.

---

## 📁 File Structure

```
project-folder/
├── index.html          # Home page
├── books.jsp           # Available Books page (dynamic)
├── borrow.html         # Borrow request form page
├── process_borrow.jsp  # Form processing page (optional)
├── style.css           # External stylesheet
└── database_setup.sql  # Database creation and sample data
```

---

## 🚀 Setup Instructions

### Prerequisites
1. **Java Development Kit (JDK)** - Version 8 or higher
2. **Apache Tomcat Server** - Version 9.0 or higher
3. **MySQL Database** - Version 5.7 or higher
4. **MySQL JDBC Driver** (Connector/J)
5. **Text Editor or IDE** (Eclipse, IntelliJ IDEA, VS Code, etc.)

### Step 1: Database Setup

1. **Start MySQL Server**
   ```bash
   # On Windows
   net start MySQL80
   
   # On Linux/Mac
   sudo systemctl start mysql
   ```

2. **Login to MySQL**
   ```bash
   mysql -u root -p
   ```

3. **Execute the SQL script**
   ```sql
   source /path/to/database_setup.sql
   ```
   
   Or manually run the commands from `database_setup.sql`:
   - Create database `library_db`
   - Create `books` table
   - Insert sample records

4. **Verify database**
   ```sql
   USE library_db;
   SELECT * FROM books;
   ```

### Step 2: Configure Database Connection

Update the database credentials in **books.jsp** and **process_borrow.jsp**:

```java
String dbURL = "jdbc:mysql://localhost:3306/library_db";
String dbUser = "root";
String dbPassword = "your_password"; // Change this!
```

### Step 3: Setup Apache Tomcat

1. **Download and Install Tomcat** from https://tomcat.apache.org/

2. **Add MySQL JDBC Driver**
   - Download `mysql-connector-java-x.x.xx.jar`
   - Place it in `[TOMCAT_HOME]/lib/` directory

3. **Create Web Application Directory**
   ```
   [TOMCAT_HOME]/webapps/library/
   ```

4. **Copy Project Files**
   ```
   library/
   ├── index.html
   ├── books.jsp
   ├── borrow.html
   ├── process_borrow.jsp
   └── style.css
   ```

### Step 4: Start Tomcat Server

```bash
# Windows
[TOMCAT_HOME]/bin/startup.bat

# Linux/Mac
[TOMCAT_HOME]/bin/startup.sh
```

### Step 5: Access the Application

Open your browser and navigate to:
```
http://localhost:8080/library/index.html
```

---

## 🎯 Features Implemented

### Part A: HTML, CSS, and Client-Side Scripting (20 Marks)

#### ✅ (i) Three HTML Pages Created
- **index.html** - Home page with library information
- **books.jsp** - Dynamic books listing page
- **borrow.html** - Borrow request form

#### ✅ (ii) CSS Styling (style.css)
- Dark header (#333) with white navigation links
- Light grey information division (#f4f4f4)
- Active navigation link highlighting (blue background)
- Responsive design with proper fonts, margins, and padding
- Status color coding (green for Available, red for Borrowed)

#### ✅ (iii) Home Page Features
- Welcoming headline
- Library mission statement
- Operating hours table
- Library image
- Navigation to other pages

#### ✅ (iv) Borrow Page with JavaScript Validation
Form fields:
- Full Name (text input)
- Email Address (email input)
- Book ID (text input)
- Borrow Date (date input)

Validation checks:
- All fields must not be empty
- Email must contain '@' and '.'
- Book ID must be a number
- Alert messages on validation failure
- Form submission prevention on errors

### Part B: JSP and Database Connectivity (20 Marks)

#### ✅ (v) Database Setup
- Database: `library_db`
- Table: `books` with schema:
  - BookID (INT, Primary Key)
  - Title (VARCHAR(100))
  - Author (VARCHAR(100))
  - Genre (VARCHAR(50))
  - Status (VARCHAR(20))
- 10 sample book records inserted

#### ✅ (vi) Available Books Page (books.jsp)
- JSP scriptlets for database connectivity
- SQL query execution to fetch all books
- Dynamic HTML table generation
- Color-coded status cells:
  - Green background for 'Available' books
  - Red background for 'Borrowed' books
- Proper error handling

#### ✅ (vii) Submission Handling Explanation
Complete explanation in `process_borrow.jsp` covering:
- Form data retrieval using `request.getParameter()`
- Database connection establishment
- Book availability checking
- Status update from 'Available' to 'Borrowed'
- Success/failure message display
- Proper resource cleanup

---

## 📸 Screenshots Required for Submission

1. **Home Page** (index.html)
   - Full page view showing header and content

2. **Available Books Page** (books.jsp)
   - Table showing all books with color-coded status

3. **Borrow Page** (borrow.html)
   - Empty form view
   - Form with validation errors (alert message)
   - Form with valid data

4. **Database**
   - MySQL command line showing table structure
   - MySQL command line showing sample data

5. **Code Screenshots**
   - index.html code
   - borrow.html code
   - books.jsp code
   - style.css code
   - JavaScript validation function
   - SQL CREATE and INSERT statements

---

## 🧪 Testing the Application

### Test Case 1: Home Page
1. Navigate to `http://localhost:8080/library/index.html`
2. Verify library information is displayed
3. Click on navigation links

### Test Case 2: Available Books
1. Navigate to Available Books
2. Verify books are displayed from database
3. Check color coding for status

### Test Case 3: Form Validation
1. Navigate to Borrow page
2. Try submitting empty form → Should show alert
3. Enter invalid email → Should show alert
4. Enter non-numeric Book ID → Should show alert
5. Fill all fields correctly → Should show success

### Test Case 4: Database Connection
1. Stop MySQL server
2. Try loading books.jsp → Should show error message
3. Restart MySQL server
4. Reload page → Should display books

---

## 📋 Submission Checklist

### Documents to Include:
- [ ] Report with all screenshots
- [ ] Complete code for index.html
- [ ] Complete code for borrow.html
- [ ] Complete code for books.jsp
- [ ] Complete code for style.css
- [ ] JavaScript validation code
- [ ] SQL CREATE TABLE statement
- [ ] SQL INSERT statements
- [ ] process_borrow.jsp explanation

### Source Files:
- [ ] index.html
- [ ] borrow.html
- [ ] books.jsp
- [ ] process_borrow.jsp
- [ ] style.css
- [ ] database_setup.sql

---

## 🐛 Troubleshooting

### Issue: Books.jsp shows error "Driver not found"
**Solution:** Ensure MySQL JDBC driver is in Tomcat's lib folder

### Issue: Database connection failed
**Solution:** 
- Check MySQL is running
- Verify database credentials
- Ensure library_db database exists

### Issue: CSS not loading
**Solution:** 
- Verify style.css is in same directory
- Check file path in `<link>` tag
- Clear browser cache

### Issue: Form validation not working
**Solution:**
- Check JavaScript console for errors
- Verify function name matches onsubmit attribute
- Ensure script tag is present

---

## 📚 Additional Notes

### Marks Distribution
- Part A (HTML, CSS, JavaScript): 20 marks
- Part B (JSP, Database): 20 marks
- Viva Voce: 10 marks
- **Total: 50 marks**

### Enhancement Suggestions
1. Add user authentication
2. Implement return date tracking
3. Create admin panel for book management
4. Add search and filter functionality
5. Implement overdue notifications
6. Generate borrowing history reports

---

## 👨‍💻 Author Information
**Course:** BCSL-057 - Web Programming Lab  
**Assignment:** BCA(V)/L-057/Assignment/2025-26  
**Maximum Marks:** 50  
**Weightage:** 25%

---

## 📞 Support
For any issues or questions regarding this implementation, please refer to:
- Course materials and textbooks
- Tomcat documentation: https://tomcat.apache.org/
- MySQL documentation: https://dev.mysql.com/doc/
- JSP tutorials: https://docs.oracle.com/javaee/5/tutorial/doc/

---

**Good luck with your assignment! 🎓**