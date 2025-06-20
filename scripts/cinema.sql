-- Drop tables in reverse order of dependencies to avoid foreign key errors
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Seat;
DROP TABLE IF EXISTS Showtime;
DROP TABLE IF EXISTS Hall;
DROP TABLE IF EXISTS Cinema;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Movie;

CREATE TABLE Movie (
 id INT PRIMARY KEY AUTO_INCREMENT,
 title VARCHAR(255) NOT NULL,
 genre VARCHAR(50),
 duration_min INT,
 rating VARCHAR(10),
 release_date DATE
);

CREATE TABLE Cinema (
 id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(255) NOT NULL,
 location VARCHAR(255) NOT NULL,
 total_hall INT
);

CREATE TABLE Hall (
 id INT PRIMARY KEY AUTO_INCREMENT,
 cinema_id INT,
 name VARCHAR(100) NOT NULL,
 capacity INT NOT NULL,
 FOREIGN KEY (cinema_id) REFERENCES Cinema(id) ON DELETE CASCADE
);

CREATE TABLE Showtime (
 id INT PRIMARY KEY AUTO_INCREMENT,
 movie_id INT,
 hall_id INT,
 start_time DATETIME NOT NULL,
 end_time DATETIME NOT NULL,
 price DECIMAL(6, 2) NOT NULL,
 FOREIGN KEY (movie_id) REFERENCES Movie(id) ON DELETE CASCADE,
 FOREIGN KEY (hall_id) REFERENCES Hall(id) ON DELETE CASCADE
);

CREATE TABLE Customer (
 id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(255) NOT NULL,
 email VARCHAR(255) UNIQUE,
 phone_number VARCHAR(15)
);

CREATE TABLE Booking (
 id INT PRIMARY KEY AUTO_INCREMENT,
 customer_id INT,
 showtime_id INT,
 booking_time DATETIME DEFAULT CURRENT_TIMESTAMP,
 num_seat INT NOT NULL,
 FOREIGN KEY (customer_id) REFERENCES Customer(id) ON DELETE CASCADE,
 FOREIGN KEY (showtime_id) REFERENCES Showtime(id) ON DELETE CASCADE
);

CREATE TABLE Seat (
 id INT PRIMARY KEY AUTO_INCREMENT,
 hall_id INT,
 seat_number VARCHAR(10) NOT NULL,
 FOREIGN KEY (hall_id) REFERENCES Hall(id) ON DELETE CASCADE
);

CREATE TABLE Booked_Seats (
 id INT PRIMARY KEY AUTO_INCREMENT,
 booking_id INT,
 seat_id INT,
 FOREIGN KEY (booking_id) REFERENCES Booking(id) ON DELETE CASCADE,
 FOREIGN KEY (seat_id) REFERENCES Seat(id) ON DELETE CASCADE
);

-- Inserting Movies
INSERT INTO Movie (title, genre, duration_min, rating, release_date) VALUES
('The Last Voyage', 'Adventure', 120, 'PG-13', '2023-01-15'),
('Silent Echo', 'Drama', 95, 'R', '2023-02-10'),
('Cosmic Odyssey', 'Sci-Fi', 150, 'PG-13', '2023-03-05'),
('Heartbreak Harmony', 'Romance', 90, 'R', '2023-04-02'),
('Epic Legends', 'Fantasy', 140, 'PG', '2023-05-18'),
('Stealth Mission', 'Action', 110, 'PG-13', '2023-06-22'),
('Mystery of Time', 'Thriller', 105, 'R', '2023-07-19'),
('Nature Whisper', 'Documentary', 80, 'NR', '2023-08-10'),
('Crazy Science', 'Comedy', 100, 'PG-13', '2023-09-14'),
('The Ancient Curse', 'Horror', 130, 'R', '2023-10-30');

-- Inserting Cinemas
INSERT INTO Cinema (name, location, total_hall) VALUES
('Cinema Paradise', '123 Main St, Cityville', 5),
('Starview Cinemas', '456 Elm St, Townsville', 3),
('Epic Lounge', '789 Oak St, Villagetown', 4),
('Silver Screen', '135 Pine St, Metropolis', 6),
('Blockbuster Theater', '246 Maple St, Agropolis', 8);

-- Inserting Halls
INSERT INTO Hall (cinema_id, name, capacity) VALUES
(1, 'Hall A1', 150),
(1, 'Hall A2', 120),
(1, 'Hall A3', 100),
(2, 'Hall B1', 80),
(2, 'Hall B2', 70),
(3, 'Hall C1', 200),
(4, 'Hall D1', 180),
(4, 'Hall D2', 150),
(5, 'Hall E1', 220),
(5, 'Hall E2', 210);

-- Inserting Showtimes
INSERT INTO Showtime (movie_id, hall_id, start_time, end_time, price) VALUES
(1, 1, '2023-01-16 18:00:00', '2023-01-16 20:00:00', 12.99),
(2, 2, '2023-02-11 19:00:00', '2023-02-11 20:35:00', 10.99),
(3, 3, '2023-03-06 20:00:00', '2023-03-06 23:00:00', 15.99),
(4, 4, '2023-04-03 17:30:00', '2023-04-03 19:00:00', 11.99),
(5, 5, '2023-05-19 19:30:00', '2023-05-19 22:00:00', 13.99),
(6, 1, '2023-06-23 20:15:00', '2023-06-23 22:00:00', 14.99),
(7, 2, '2023-07-20 18:30:00', '2023-07-20 20:15:00', 9.99),
(8, 3, '2023-08-11 16:00:00', '2023-08-11 17:20:00', 8.99),
(9, 4, '2023-09-15 19:15:00', '2023-09-15 21:00:00', 10.99),
(10, 5, '2023-10-31 21:00:00', '2023-10-31 23:00:00', 17.99);

-- Inserting Customers
INSERT INTO Customer (name, email, phone_number) VALUES
('John Doe', 'john.doe@example.com', '1234567890'),
('Jane Smith', 'jane.smith@example.com', '1234567891'),
('Alice Johnson', 'alice.j@example.com', '1234567892'),
('Bob Brown', 'bob.brown@example.com', '1234567893'),
('Charlie White', 'charlie.white@example.com', '1234567894'),
('Daisy Green', 'daisy.green@example.com', '1234567895'),
('Edward Black', 'edward.black@example.com', '1234567896'),
('Fiona Blue', 'fiona.blue@example.com', '1234567897'),
('George Red', 'george.red@example.com', '1234567898'),
('Hannah Yellow', 'hannah.yellow@example.com', '1234567899');

-- Inserting Bookings
INSERT INTO Booking (customer_id, showtime_id, num_seat) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 3, 1),
(4, 4, 4),
(5, 5, 5),
(6, 6, 2),
(7, 7, 1),
(8, 8, 3),
(9, 9, 2),
(10, 10, 1);

-- Inserting Seats
INSERT INTO Seat (hall_id, seat_number) VALUES
(1, 'A1'),
(1, 'A2'),
(1, 'A3'),
(1, 'A4'),
(1, 'A5'),
(2, 'B1'),
(2, 'B2'),
(2, 'B3'),
(2, 'B4'),
(2, 'B5'),
(3, 'C1'),
(3, 'C2'),
(3, 'C3'),
(3, 'C4'),
(3, 'C5'),
(4, 'D1'),
(4, 'D2'),
(4, 'D3'),
(4, 'D4'),
(4, 'D5'),
(5, 'E1'),
(5, 'E2'),
(5, 'E3'),
(5, 'E4'),
(5, 'E5');

INSERT INTO Booked_Seats (booking_id, seat_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 6),
(4, 7),
(4, 8),
(4, 9),
(4, 10),
(5, 11),
(5, 12),
(5, 13),
(5, 14),
(5, 15),
(6, 16),
(6, 17),
(7, 18),
(8, 19),
(8, 20),
(8, 21),
(9, 22),
(9, 23);

-- Make sure to adjust the data volume for seats to match the actual capacity of each hall.


