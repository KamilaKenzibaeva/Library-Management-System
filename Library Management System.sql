USE [LIBRARY MANAGEMENT];

CREATE TABLE Members
	(MemberID int,
	Name nchar(50),
	Address nchar(30),
	Email nchar(20),
	Phone nchar(20),
	UserID int,
	ExpiryDate date,
	MembershipDate date,
	PRIMARY KEY (MemberID));

CREATE TABLE Users
	(User_ID int ,
	MemberID int ,
	UserType nchar(10),
	Username nchar(20),
	Password nchar(10),
	PRIMARY KEY (User_ID),
	FOREIGN KEY (MemberID) REFERENCES Members(MemberID)); 

CREATE TABLE Management_System
	(ID int ,
	UserID int ,
	User_ID int,
	logindatetime datetime2(7),
	logoutdatatime datetime2(7),
	PRIMARY KEY (ID),
	FOREIGN KEY (User_ID) REFERENCES Users(User_ID)); 

CREATE TABLE System_Notifications
	(NotificationID int ,
	User_ID int ,
	Message nchar(100),
	Notification_Date datetime2(7),
	Status nchar(10),
	PRIMARY KEY (NotificationID),
	FOREIGN KEY (User_ID) REFERENCES Users(User_ID));

CREATE TABLE Librarian
	(Librarian_ID int,
	User_ID int,
	Librarian_Name nchar(20),
	Email nchar(20),
	Phone nchar(20),
	PRIMARY KEY (Librarian_ID),
	FOREIGN KEY (User_ID) REFERENCES Users(User_ID));

CREATE TABLE Department
	(Department_ID int,
	DepartmentName nchar(20),
	PRIMARY KEY (Department_ID));

CREATE TABLE Staff
	(Staff_ID int,
	UserID int,
	EmployeeNumber nchar(20),
	Position nchar(10),
	DepartmentID int,
	HireDate date,
	PRIMARY KEY (Staff_ID),
	FOREIGN KEY (UserID) REFERENCES Users(User_ID),
	FOREIGN KEY (DepartmentID) REFERENCES Department(Department_ID));

CREATE TABLE Book
	(Book_ID int,
	Author int,
	Subject nchar(20),
	ISBN nchar(20),
	Title nchar(50),
	RackNumber int,
	Date_of_Publication date,
	PRIMARY KEY (Book_ID));

CREATE TABLE Student
	(Student_ID int,
	MemberID int,
	EnrollmentNumber nchar(20),
	Student_Name nchar(20),
	Course nchar(50),
	UserID int,
	Year date,
	PRIMARY KEY (Student_ID),
	FOREIGN KEY (UserID) REFERENCES Users(User_ID),
	FOREIGN KEY (MemberID) REFERENCES Members(MemberID));

CREATE TABLE BooksRacks
	(RackID int,
	BookID int,
	Location nchar(30),
	PRIMARY KEY (RackID),
	FOREIGN KEY (BookID) REFERENCES Book(Book_ID));

CREATE TABLE Account
	(AccountID int,
	BookID int,
	MemberID int,
	Actions nchar(20),
	DueDate date,
	ReturnDate date,
	PRIMARY KEY (AccountID),
	FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
	FOREIGN KEY (BookID) REFERENCES Book(Book_ID));

CREATE TABLE Fine_Details
	(FineID int,
	AccountID int,
	Amount float,
	FineDate date,
	Status nchar(20),
	PRIMARY KEY (FineID),
	FOREIGN KEY (AccountID) REFERENCES Account(AccountID));

/*Normalization */

CREATE TABLE Author (
    AuthorID int,
    Name nchar(30),
    Bio ntext,
    PRIMARY KEY (AuthorID));

CREATE TABLE Subject (
    SubjectID int,
    Name nchar(30),
    Description ntext,
    PRIMARY KEY (SubjectID));

CREATE TABLE UserType (
    TypeID int,
    TypeName nchar(20),  --  'Librarian', 'Student', 'Staff'
    Description ntext,
    PRIMARY KEY (TypeID));

ALTER TABLE Users
ADD TypeID int,
FOREIGN KEY (TypeID) REFERENCES UserType(TypeID);

ALTER TABLE Book
ADD AuthorID int;

ALTER TABLE Book
ADD SubjectID int;

ALTER TABLE Book
DROP COLUMN Author;

ALTER TABLE Book
DROP COLUMN Subject;

ALTER TABLE Book
ADD CONSTRAINT FK_Book_Author
FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID);

ALTER TABLE Book
ADD CONSTRAINT FK_Book_Subject
FOREIGN KEY (SubjectID) REFERENCES Subject(SubjectID);

ALTER TABLE Members
ALTER COLUMN Name nchar(50);

ALTER TABLE Staff
ADD TypeID int;

ALTER TABLE Staff
DROP COLUMN Position;

ALTER TABLE Staff
ADD CONSTRAINT FK_Staff_UserType
FOREIGN KEY (TypeID) REFERENCES UserType(TypeID);

ALTER TABLE Student
ADD TypeID int,
FOREIGN KEY (TypeID) REFERENCES UserType(TypeID);

ALTER TABLE Librarian
ADD TypeID int,
FOREIGN KEY (TypeID) REFERENCES UserType(TypeID);

/*inserting data into tables*/

INSERT INTO Members (MemberID, Name, Address, Email, Phone, UserID, ExpiryDate, MembershipDate)
VALUES 
(1, 'John Doe', '123 Main St', 'joh@email.com', '123-456-7890', 1, '2023-12-31', '2023-01-01'),
(2, 'Jane Smith', '456 Oak Ave', 'jan@email.com', '234-567-8901', 2, '2024-01-01', '2023-02-01'),
(3, 'Alice Johnson', '789 Pine Rd', 'alice@email.com', '345-678-9012', 3, '2024-02-01', '2023-03-01'),
(4, 'Bob Brown', '321 Cedar Blvd', 'bobb@email.com', '456-789-0123', 4, '2024-03-01', '2023-04-01'),
(5, 'Carol White', '654 Maple Ln', 'carolw@email.com', '567-890-1234', 5, '2024-04-01', '2023-05-01');

INSERT INTO Users (User_ID, MemberID, UserType, Username, Password)
VALUES 
(1, 1, 'Member', 'john_doe', 'password12'),
(2, 2, 'Member', 'jane_smith', 'password34'),
(3, 3, 'Librarian', 'alice_johnson', 'password45'),
(4, 4, 'Staff', 'bob_brown', 'password56'),
(5, 5, 'Student', 'carol_white', 'password67');

INSERT INTO Management_System (ID, UserID, User_ID, logindatetime, logoutdatatime)
VALUES 
(1, 1, 1, '2023-01-01 08:00:00', '2023-01-01 16:00:00'),
(2, 2, 2, '2023-01-02 08:30:00', '2023-01-02 16:30:00'),
(3, 3, 3, '2023-01-03 09:00:00', '2023-01-03 17:00:00'),
(4, 4, 4, '2023-01-04 09:30:00', '2023-01-04 17:30:00'),
(5, 5, 5, '2023-01-05 10:00:00', '2023-01-05 18:00:00');

INSERT INTO System_Notifications (NotificationID, User_ID, Message, Notification_Date, Status)
VALUES 
(1, 1, 'Welcome to the Library System', '2023-01-01 08:00:00', 'Sent'),
(2, 2, 'Your book reservation is ready', '2023-01-02 09:00:00', 'Sent'),
(3, 3, 'Library closing early today', '2023-01-03 10:00:00', 'Sent'),
(4, 4, 'New arrivals in the fiction section', '2023-01-04 11:00:00', 'Sent'),
(5, 5, 'Reminder: Book due date approaching', '2023-01-05 12:00:00', 'Sent');

INSERT INTO Department (Department_ID, DepartmentName)
VALUES 
(1, 'Literature'),
(2, 'Science'),
(3, 'Arts'),
(4, 'Technology'),
(5, 'History');

INSERT INTO Staff (Staff_ID, UserID, EmployeeNumber, DepartmentID, HireDate)
VALUES 
(1, 2, 'EMP001', 4, '2021-01-01'),
(2, 3, 'EMP002', 1, '2021-06-01'),
(3, 4, 'EMP003', 3, '2022-01-01'),
(4, 5, 'EMP004', 3, '2022-07-01');

INSERT INTO Author (AuthorID, Name, Bio)
VALUES 
(1, 'Mark Twain', 'An American writer known for his humor and social criticism.'),
(2, 'Jane Austen', 'An English novelist known for her romantic fiction.'),
(3, 'Isaac Asimov', 'A prolific science fiction author and biochemistry professor.'),
(4, 'Agatha Christie', 'A British writer known for her detective novels.'),
(5, 'William Shakespeare', 'An English playwright, widely regarded as the greatest writer in the English language.');

INSERT INTO Subject (SubjectID, Name, Description)
VALUES 
(1, 'Science Fiction', 'Books that explore imaginative and futuristic concepts.'),
(2, 'Romance', 'Literature that focuses on love and romantic relationships.'),
(3, 'Mystery', 'Novels dealing with solving a mystery, usually a crime or a puzzle.'),
(4, 'Biography', 'A detailed description of a person'),
(5, 'History', 'Books that explore historical events and periods.');

INSERT INTO Book (Book_ID, ISBN, Title, RackNumber, Date_of_Publication, AuthorID, SubjectID)
VALUES 
(1, '978-3-16-148410-0', 'Book Title 1', 101, '2020-01-01',1, 1),
(2, '978-3-16-148410-1', 'Book Title 2', 102, '2020-06-01', 2, 2),
(3, '978-3-16-148410-2', 'Book Title 3', 103, '2021-01-01', 3, 3),
(4,'978-3-16-148410-3', 'Book Title 4', 104, '2021-06-01', 4, 4),
(5,'978-3-16-148410-4', 'Book Title 5', 105, '2022-01-01', 5, 5);

INSERT INTO Student (Student_ID, MemberID, EnrollmentNumber, Student_Name, Course, UserID, Year)
VALUES 
(1, 2, 'ENR001', 'Carol White', 'Biology', 5, '2022-01-01'),
(2, 1, 'ENR002', 'Gary Black', 'Computer Science', 1, '2022-02-01'),
(3, 3, 'ENR003', 'Helen Grey', 'English Literature', 2, '2023-01-01'),
(4, 4, 'ENR004', 'Ivan Blue', 'Physics', 4, '2023-02-01'),
(5, 5, 'ENR005', 'Julia Green', 'Fine Arts', 3, '2023-03-01');

INSERT INTO BooksRacks (RackID, BookID, Location)
VALUES 
(1, 1, 'First Floor - Section A'),
(2, 2, 'First Floor - Section B'),
(3, 3, 'Second Floor - Section A'),
(4, 4, 'Second Floor - Section B'),
(5, 5, 'Third Floor - Section A');

INSERT INTO Account (AccountID, BookID, MemberID, Actions, DueDate, ReturnDate)
VALUES 
(1, 1, 1, 'Borrowed', '2023-02-01', '2023-02-15'),
(2, 2, 2, 'Borrowed', '2023-03-01', '2023-03-15'),
(3, 3, 3, 'Returned', '2022-12-01', '2022-12-15'),
(4, 4, 4, 'Renewed', '2023-01-01', '2023-01-30'),
(5, 5, 5, 'Borrowed', '2023-04-01', '2023-04-15');

INSERT INTO Fine_Details (FineID, AccountID, Amount, FineDate, Status)
VALUES 
(1, 1, 5.00, '2023-02-16', 'Unpaid'),
(2, 2, 2.50, '2023-03-16', 'Paid'),
(3, 3, 0.00, '2022-12-16', 'Paid'),
(4, 4, 1.00, '2023-01-31', 'Unpaid'),
(5, 5, 3.00, '2023-04-16', 'Unpaid');

INSERT INTO Librarian (Librarian_ID, User_ID, Librarian_Name, Email, Phone)
VALUES 
(1, 3, 'Alice Johnson', 'alicejo@email.com', '345-678-9012'),
(2, 2, 'David Green', 'davidgr@email.com', '678-901-2345'),
(3, 1, 'Emma Wilson', 'emmawil@email.com', '789-012-3456'),
(4, 4, 'Frank Murphy', 'frankmuy@email.com', '890-123-4567'),
(5, 5, 'Grace Lee', 'gracel@email.com', '901-234-5678');

/*Queries for each table*/

SELECT * FROM Members 
WHERE ExpiryDate BETWEEN '2023-01-01' AND '2023-12-31'
AND Address LIKE '%St%';

SELECT Name, Email FROM Members 
WHERE MembershipDate < '2023-04-01' 
OR Phone LIKE '123%';

SELECT COUNT(*) AS TotalMembers FROM Members 
WHERE Email LIKE '%@email.com%'
GROUP BY UserID
HAVING COUNT(*) > 1;

SELECT * FROM Members 
WHERE MemberID NOT IN (SELECT MemberID FROM Account WHERE Actions = 'Borrowed');

SELECT Username FROM Users 
WHERE UserType IN ('Librarian', 'Staff');

SELECT COUNT(User_ID) AS NumUsers FROM Users 
WHERE UserType = 'Member'
GROUP BY UserType
HAVING COUNT(User_ID) >= 2;

SELECT * FROM Users 
WHERE Username LIKE 'a%' 
AND UserType = 'Librarian';

SELECT UserType, COUNT(User_ID) AS Count FROM Users 
WHERE UserType NOT LIKE 'Student'
GROUP BY UserType;

SELECT * FROM Management_System 
WHERE logindatetime BETWEEN '2023-01-01' AND '2023-01-31'
AND logoutdatatime IS NOT NULL;

SELECT * FROM Management_System 
WHERE User_ID IN (SELECT User_ID FROM Users WHERE UserType = 'Librarian');

SELECT MAX(logoutdatatime) AS LastLogout, UserID FROM Management_System 
GROUP BY UserID
HAVING MAX(logoutdatatime) < '2023-01-31';

SELECT * FROM System_Notifications 
WHERE Notification_Date BETWEEN '2023-01-01' AND '2023-01-31'
AND Status = 'Sent';

SELECT COUNT(NotificationID) AS TotalNotifications, User_ID FROM System_Notifications 
WHERE Status = 'Sent'
GROUP BY User_ID;

SELECT Message FROM System_Notifications 
WHERE User_ID IN (SELECT User_ID FROM Users WHERE UserType LIKE '%Staff%')
AND Status = 'Sent';

SELECT * FROM Department 
WHERE DepartmentName LIKE '%s%';

SELECT COUNT(Department_ID) FROM Department 
WHERE DepartmentName NOT LIKE 'Science';

SELECT DepartmentName FROM Department 
WHERE Department_ID IN (1, 2, 4);

SELECT DepartmentName FROM Department 
WHERE Department_ID BETWEEN 1 AND 3;

SELECT EmployeeNumber FROM Staff 
WHERE HireDate > '2021-01-01'
GROUP BY EmployeeNumber;

SELECT * FROM Staff 
WHERE DepartmentID = 3 
AND HireDate BETWEEN '2021-01-01' AND '2023-01-01';

SELECT DepartmentID FROM Staff 
WHERE DepartmentID IN (2, 3) 
OR HireDate < '2022-01-01';

SELECT * FROM Author 
WHERE Name LIKE '%Twain%';

SELECT Name FROM Author 
WHERE AuthorID IN (1, 3, 5);

SELECT * FROM Author 
WHERE Bio LIKE '%English%' 
OR Bio LIKE '%American%';

SELECT * FROM Subject 
WHERE Name LIKE '%History%';

SELECT COUNT(SubjectID) FROM Subject 
WHERE Name IN ('Science Fiction', 'Romance');

SELECT * FROM Subject 
WHERE Description NOT LIKE '%crime%';

SELECT * FROM Book 
WHERE Date_of_Publication BETWEEN '2020-01-01' AND '2022-01-01';

SELECT Title FROM Book 
WHERE ISBN LIKE '97%' 
AND RackNumber > 100;

SELECT * FROM Student 
WHERE Course LIKE '%Science%';

SELECT Student_Name FROM Student 
WHERE Year BETWEEN '2022-01-01' AND '2023-01-01';

SELECT COUNT(Student_ID) FROM Student 
WHERE Course IN ('Biology', 'Computer Science');

SELECT Course, COUNT(Student_ID) FROM Student 
GROUP BY Course
HAVING COUNT(Student_ID) >= 1;

SELECT * FROM BooksRacks 
WHERE Location LIKE '%Floor%';

SELECT * FROM BooksRacks 
WHERE BookID IN (SELECT Book_ID FROM Book WHERE Title LIKE '%Title 1%');

SELECT Location FROM BooksRacks 
WHERE RackID BETWEEN 1 AND 3 
OR Location LIKE '%Section A%';

SELECT MemberID, COUNT(AccountID) FROM Account 
WHERE Actions = 'Borrowed'
GROUP BY MemberID
HAVING COUNT(AccountID) >= 2;

SELECT * FROM Account 
WHERE DueDate BETWEEN '2023-02-01' AND '2023-03-31';

SELECT * FROM Account 
WHERE ReturnDate IS NOT NULL 
AND Actions = 'Returned';

SELECT * FROM Fine_Details 
WHERE Amount > 0 
AND Status = 'Unpaid';

SELECT AccountID, COUNT(FineID) FROM Fine_Details 
WHERE Status = 'Paid'
GROUP BY AccountID
HAVING COUNT(FineID) >= 1;

SELECT * FROM Librarian 
WHERE Email LIKE '%email.com%';

SELECT COUNT(Librarian_ID) FROM Librarian 
WHERE Phone NOT LIKE '345%';

/*Triggers*/

/*Trigger to update the MembershipDate in the Members table when a new user is added*/
CREATE TRIGGER UpdateMembershipDate
ON Users
AFTER INSERT
AS
BEGIN
    UPDATE Members
    SET MembershipDate = GETDATE()
    WHERE MemberID IN (SELECT MemberID FROM inserted);
END;

/*Trigger to log login activities in the Management_System table*/
CREATE TRIGGER LogLoginActivity
ON Management_System
AFTER INSERT
AS
BEGIN
    INSERT INTO Management_System (UserID, User_ID, logindatetime)
    SELECT UserID, User_ID, GETDATE()
    FROM inserted;
END;

/*Views*/

/*View to display information about books and their authors*/
CREATE VIEW BookInfo AS
SELECT b.Book_ID, b.Title, a.Name AS Author
FROM Book b
JOIN Author a ON b.AuthorID = a.AuthorID;

/*View to list all active members and their expiration dates*/
CREATE VIEW ActiveMembers AS
SELECT MemberID, Name, ExpiryDate
FROM Members
WHERE ExpiryDate >= GETDATE();


/*Functions*/

/*Function to calculate the total fine amount for a given member*/
CREATE FUNCTION CalculateTotalFine(@MemberID int)
RETURNS float
AS
BEGIN
    DECLARE @TotalFineAmount float;
    
    SELECT @TotalFineAmount = SUM(Amount)
    FROM Fine_Details fd
    JOIN Account a ON fd.AccountID = a.AccountID
    WHERE a.MemberID = @MemberID;
    
    RETURN @TotalFineAmount;
END;

/*Function to retrieve the number of books borrowed by a student*/
CREATE FUNCTION CountBooksBorrowed(@StudentID int)
RETURNS int
AS
BEGIN
    DECLARE @BorrowedCount int;
    
    SELECT @BorrowedCount = COUNT(*)
    FROM Account a
    WHERE a.MemberID = (SELECT MemberID FROM Student WHERE Student_ID = @StudentID)
    AND a.Actions = 'Borrowed';
    
    RETURN @BorrowedCount;
END;


/*Procedures*/

/*Stored procedure to add a new book to the library*/

CREATE PROCEDURE AddBook
    @ISBN nchar(20),
    @Title nchar(50),
    @RackNumber int,
    @Date_of_Publication date,
    @AuthorID int,
    @SubjectID int
AS
BEGIN
    INSERT INTO Book (ISBN, Title, RackNumber, Date_of_Publication, AuthorID, SubjectID)
    VALUES (@ISBN, @Title, @RackNumber, @Date_of_Publication, @AuthorID, @SubjectID);
END;

/*Stored procedure to update a member's address*/

CREATE PROCEDURE UpdateMemberAddress
    @MemberID int,
    @NewAddress nchar(30)
AS
BEGIN
    UPDATE Members
    SET Address = @NewAddress
    WHERE MemberID = @MemberID;
END;














































