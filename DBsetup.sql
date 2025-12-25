-- Create Database
CREATE DATABASE IF NOT EXISTS library_db;

-- Use the database
USE library_db;

-- Create books table
CREATE TABLE IF NOT EXISTS books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Genre VARCHAR(50) NOT NULL,
    Status VARCHAR(20) NOT NULL
);

-- Insert sample records (at least 5 books)
INSERT INTO books (BookID, Title, Author, Genre, Status) VALUES
(101, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 'Available'),
(102, '1984', 'George Orwell', 'Dystopian', 'Available'),
(103, 'Pride and Prejudice', 'Jane Austen', 'Romance', 'Borrowed'),
(104, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 'Available'),
(105, 'Moby Dick', 'Herman Melville', 'Adventure', 'Available'),
(106, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 'Borrowed'),
(107, 'Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 'Fantasy', 'Available'),
(108, 'The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 'Available'),
(109, 'Brave New World', 'Aldous Huxley', 'Science Fiction', 'Borrowed'),
(110, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy', 'Available');

-- Verify the data
SELECT * FROM books;