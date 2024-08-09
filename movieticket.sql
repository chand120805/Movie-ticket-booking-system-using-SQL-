
CREATE DATABASE MovieTicketBookingSystem;
USE MovieTicketBookingSystem;

-- Create Movie table
CREATE TABLE Movie (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_name VARCHAR(255) NOT NULL,
    movie_language VARCHAR(50),
    movie_type VARCHAR(50),
    movie_hour TIME,
    movie_description TEXT
);

-- Create Customer table
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    customer_mobile VARCHAR(15),
    customer_email VARCHAR(255),
    customer_username VARCHAR(50) UNIQUE,
    customer_password VARCHAR(255),
    customer_address TEXT
);

-- Create Booking table
CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_title VARCHAR(255),
    booking_type VARCHAR(50),
    booking_ticket INT,
    booking_date DATE,
    booking_description TEXT,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create Payment table
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_customer_id INT,
    payment_date DATE,
    payment_amount DECIMAL(10, 2),
    payment_description TEXT,
    FOREIGN KEY (payment_customer_id) REFERENCES Customer(customer_id)
);

-- Create Seats table
CREATE TABLE Seats (
    seat_id INT AUTO_INCREMENT PRIMARY KEY,
    seat_movie_id INT,
    seat_customer_id INT,
    seat_number INT,
    seat_type VARCHAR(50),
    seat_description TEXT,
    FOREIGN KEY (seat_movie_id) REFERENCES Movie(movie_id),
    FOREIGN KEY (seat_customer_id) REFERENCES Customer(customer_id)
);

-- Create Shows table
CREATE TABLE Shows (
    show_id INT AUTO_INCREMENT PRIMARY KEY,
    show_name VARCHAR(255),
    show_type VARCHAR(50),
    show_time TIME,
    show_date DATE,
    show_description TEXT
);

-- Create an index for faster queries (example for Movie table)
CREATE INDEX idx_movie_name ON Movie(movie_name);
CREATE INDEX idx_customer_username ON Customer(customer_username);
CREATE INDEX idx_booking_date ON Booking(booking_date);
CREATE INDEX idx_payment_date ON Payment(payment_date);
CREATE INDEX idx_seat_number ON Seats(seat_number);
CREATE INDEX idx_show_date ON Shows(show_date);

-- Example of how to create relationships and ensure normalization:
-- Booking table has a foreign key referencing Customer table
ALTER TABLE Booking
ADD CONSTRAINT FK_Booking_Customer
FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);

-- Seats table has foreign keys referencing Movie and Customer tables
ALTER TABLE Seats
ADD CONSTRAINT FK_Seats_Movie
FOREIGN KEY (seat_movie_id) REFERENCES Movie(movie_id);

ALTER TABLE Seats
ADD CONSTRAINT FK_Seats_Customer
FOREIGN KEY (seat_customer_id) REFERENCES Customer(customer_id);

-- Payment table has a foreign key referencing Customer table
ALTER TABLE Payment
ADD CONSTRAINT FK_Payment_Customer
FOREIGN KEY (payment_customer_id) REFERENCES Customer(customer_id);

INSERT INTO Movie (movie_name, movie_language, movie_type, movie_hour, movie_description) 
VALUES 
('Inception', 'English', 'Sci-Fi', '02:28:00', 'A mind-bending thriller directed by Christopher Nolan.'),
('The Shawshank Redemption', 'English', 'Drama', '02:22:00', 'A gripping tale of hope and redemption.'),
('The Dark Knight', 'English', 'Action', '02:32:00', 'Christopher Nolan\'s masterpiece featuring Batman and the Joker.'),
('Interstellar', 'English', 'Sci-Fi', '02:49:00', 'An epic journey through space and time directed by Christopher Nolan.');

SELECT * FROM `movie`

-- Insert values into Shows table
INSERT INTO Shows (show_name, show_type, show_time, show_date, show_description)
VALUES 
('Inception - Matinee', 'Regular', '12:00:00', '2024-06-15', 'Matinee show for the movie Inception.'),
('Inception - Evening', 'Regular', '18:00:00', '2024-06-15', 'Evening show for the movie Inception.'),
('The Shawshank Redemption - Evening', 'Regular', '19:00:00', '2024-06-15', 'Evening show for the movie The Shawshank Redemption.'),
('The Dark Knight - Late Night', 'Regular', '21:00:00', '2024-06-15', 'Late night show for the movie The Dark Knight.');

SELECT * FROM `shows`

 Insert values into Seats table
INSERT INTO Seats (seat_movie_id, seat_number, seat_type, seat_description)
SELECT 
    movie_id, 
    seat_number, 
    'Regular', 
    CONCAT('Regular seat for movie ', movie_name) 
FROM 
    Movie 
CROSS JOIN 
    (SELECT * FROM (SELECT 1 AS seat_number UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) AS seats) AS seat_numbers;
SELECT * FROM `seats`

--1. Register/Login as a Customer
--Register:

INSERT INTO Customer (customer_name, customer_mobile, customer_email, customer_username, customer_password, customer_address)
VALUES ('Sushank', '1234567890', 'sush@example.com', 'sushank07', 'password123', 'Langarhouse,Hyd');


--Login:

SELECT customer_id FROM Customer WHERE customer_username = 'sushank07' AND customer_password = 'password123';

--2. Browse Movies
SELECT * FROM Movie;


SELECT * FROM `movie`

--3. Select a Movie and Show
Select a movie:

SELECT * FROM Movie WHERE movie_id = 1;

--Select a show for the movie:

SELECT * FROM Shows WHERE show_id = 1;

--4. Choose Seats

SELECT * FROM Seats WHERE seat_movie_id = 1 AND seat_customer_id IS NULL;

 --5. Make a Booking

INSERT INTO Booking (booking_title, booking_type, booking_ticket, booking_date, booking_description, customer_id)
VALUES ('Booking for Movie 1', 'Online', 2, '2024-06-15', 'Evening Show', 1);

--6. Make Payment

INSERT INTO Payment (payment_customer_id, payment_date, payment_amount, payment_description)
VALUES (1, '2024-06-15', 20.00, 'Payment for booking 1');

--7. Confirm Booking
--Update seat information with customer ID:

UPDATE Seats
SET seat_customer_id = 1
WHERE seat_id IN (SELECT seat_id FROM Seats WHERE seat_movie_id = 1 AND seat_number IN (1, 2));


--Confirmation query:

SELECT * FROM Booking WHERE booking_id = LAST_INSERT_ID();
SELECT * FROM Payment WHERE payment_id = LAST_INSERT_ID();
SELECT * FROM Seats WHERE seat_customer_id = 1 AND seat_movie_id = 1;


