-- CREATE TABLES --
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(100),
    published_year YEAR,
    is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE Members (
    member_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(15),
    join_date DATE DEFAULT (CURRENT_DATE)
);


CREATE TABLE Librarians (
    librarian_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(15),
    hire_date DATE DEFAULT (CURRENT_DATE)
);


CREATE TABLE Borrowing (
    loan_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrow_date DATE DEFAULT (CURRENT_DATE),
    return_date DATE,
    librarian_id INT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (librarian_id) REFERENCES Librarians(librarian_id)
);

-- INSERT VALUES ----
INSERT INTO Books (title, author, genre, published_year)
VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925),
('1984', 'George Orwell', 'Dystopian', 1949),
('To Kill a Mockingbird', 'Harper Lee', 'Classic', 1960);

INSERT INTO Members (name, email, phone_number)
VALUES
('Alen King', 'alenking@example.com', '1234567890'),
('Alece Hofman', 'alecehofman@example.com', '9876543210');

INSERT INTO Librarians (name, email, phone_number)
VALUES
('Nail Horn', 'nail@example.com', '4567891230'),
('Garden McGraw', 'garden@example.com', '7894561230');

INSERT INTO Borrowing (book_id, member_id, librarian_id, borrow_date)
VALUES (1, 1, 1, CURRENT_DATE);

UPDATE Books
SET is_available = FALSE
WHERE book_id = 1;
SELECT * FROM Books;

--  RETURN A BOOK

-- Update the borrowing record to show that the book has been returned
UPDATE Borrowing

-- Set the return date to today's date
SET return_date = CURRENT_DATE

-- Identify the specific borrowing transaction
WHERE loan_id = 1;

-- MAKE THE RETURNED BOOK AVAILABLE AGAIN

-- Update the Books table
UPDATE Books

-- Change the availability status to TRUE
SET is_available = TRUE

-- Identify the returned book
WHERE book_id = 1;


-- Verify that the book is now available
SELECT * FROM Books;

-- CHECK AVAILABLE BOOKS

-- Retrieve all columns from the Books table
SELECT *

-- Specify the table
FROM Books

-- Show only books marked as available
WHERE is_available = TRUE;

--  VIEW A MEMBER'S BORROWING HISTORY

-- Select the member's name, book title, borrowing date, and return date
SELECT
    m.name,
    b.title,
    br.borrow_date,
    br.return_date

-- Start with the Borrowing table and give it the short name br
FROM Borrowing br

-- Connect Borrowing to Members to get the member's name
JOIN Members m ON br.member_id = m.member_id

-- Connect Borrowing to Books to get the book title
JOIN Books b ON br.book_id = b.book_id

-- Show borrowing history for member ID 1 (Alen King)
WHERE m.member_id = 1;

-- FIND OVERDUE BOOKS

-- Retrieve the loan ID, member ID, book ID, and borrowing date
SELECT
    loan_id,
    member_id,
    book_id,
    borrow_date

-- Get the records from the Borrowing table
FROM Borrowing

-- Show books borrowed more than 14 days ago and not yet returned
WHERE borrow_date < CURRENT_DATE - INTERVAL 14 DAY
AND return_date IS NULL;

-- FIND BOOKS BY A SPECIFIC AUTHOR

-- Retrieve all columns from the Books table
SELECT *

-- Specify the table
FROM Books

-- Filter books written by George Orwell
WHERE author = 'George Orwell';

-- STEP 13: FIND BOOKS PUBLISHED AFTER A CERTAIN YEAR

-- Retrieve the book title, author, and publication year
SELECT
    title,
    author,
    published_year

-- Specify the Books table
FROM Books

-- Show books published after 1950
WHERE published_year > 1950;

-- COUNT THE TOTAL NUMBER OF BOOKS

-- Count all book records and name the result total_books
SELECT COUNT(*) AS total_books

-- Specify the Books table
FROM Books;

-- FIND MEMBERS WHO BORROWED A SPECIFIC BOOK

-- Retrieve the member's name and the book title
SELECT
    m.name,
    b.title

-- Start with the Borrowing table
FROM Borrowing br

-- Connect Borrowing to Members
JOIN Members m ON br.member_id = m.member_id

-- Connect Borrowing to Books
JOIN Books b ON br.book_id = b.book_id

-- Filter for The Great Gatsby
WHERE b.title = 'The Great Gatsby';

-- FIND BORROWING HISTORY OF A SPECIFIC MEMBER

-- Retrieve the member's name, book title, and borrowing dates
SELECT
    m.name,
    b.title,
    br.borrow_date,
    br.return_date

-- Start with the Borrowing table
FROM Borrowing br

-- Connect Borrowing to Members
JOIN Members m ON br.member_id = m.member_id

-- Connect Borrowing to Books
JOIN Books b ON br.book_id = b.book_id

-- Filter records belonging to Alen King
WHERE m.name = 'Alen King';


--  COUNT BOOKS BORROWED BY EACH MEMBER

-- Retrieve each member's name and number of borrowed books
SELECT
    m.name,
    COUNT(br.loan_id) AS total_books_borrowed

-- Start with the Members table
FROM Members m

-- Connect each member to their borrowing records
LEFT JOIN Borrowing br ON m.member_id = br.member_id

-- Group records by each member
GROUP BY m.member_id, m.name;

--  FIND BOOKS OVERDUE FOR MORE THAN 30 DAYS

-- Retrieve the loan ID, book ID, member ID, and borrowing date
SELECT
    loan_id,
    book_id,
    member_id,
    borrow_date

-- Get records from the Borrowing table
FROM Borrowing

-- Find books borrowed more than 30 days ago
WHERE borrow_date < CURRENT_DATE - INTERVAL 30 DAY

-- Include only books that have not been returned
AND return_date IS NULL;

-- RANK LIBRARIANS BY NUMBER OF BORROWINGS

-- Retrieve each librarian's name and number of borrowings
SELECT
    l.name,
    COUNT(br.loan_id) AS total_borrowings

-- Start with the Librarians table
FROM Librarians l

-- Connect librarians to their borrowing records
LEFT JOIN Borrowing br
ON l.librarian_id = br.librarian_id

-- Group borrowing records by librarian
GROUP BY l.librarian_id, l.name

-- Display the librarian with the most borrowings first
ORDER BY total_borrowings DESC;

-- FIND ALL BOOKS CURRENTLY BORROWED

-- Retrieve the book title, member name, and borrowing date
SELECT
    b.title,
    m.name,
    br.borrow_date

-- Start with the Borrowing table
FROM Borrowing br

-- Connect borrowing records to Books
JOIN Books b
ON br.book_id = b.book_id

-- Connect borrowing records to Members
JOIN Members m
ON br.member_id = m.member_id

-- Show only borrowing records without a return date
WHERE br.return_date IS NULL;
