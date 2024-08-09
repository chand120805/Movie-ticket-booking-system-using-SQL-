# Movie-ticket-booking-system-using-SQL-
It is a simple SQL project to facilitate the easy  reservation of movie tickets while ensuring data integrity,security, and a user-friendly interface.

LIST OF ENTITIES AND ATTRIBUTES:
* Movie Entity: Attributes of Movie are movie_id, movie_name, movie_language, movie_type, movie_hour, movie_description

* Customer Entity: Attributes of Customer are customer_id, customer_name, customer_mobile, customer_email, customer_username, customer_password, customer_address

* Booking Entity: Attributes of Booking are booking_id, booking_title, booking_type, booking_ticket, booking_date, booking_description

* Payment Entity: Attributes of Payment are payment_id, payment_customer_id, payment_date, payment_amount, payment_description

* Seats Entity: Attributes of Seats are seat_id, seat_movie_id, seat_customer_id, seat_number, seat_type, seat_description

* Shows Entity: Attributes of Shows are show_id, show_name, show_type, show_time, show_date, show_description

GENERAL PROCEDURE TO BOOK TICKET:
1. Register/Login as a Customer:
   - If you are a new user, you need to create an account by providing your details such as name, mobile, email, username, password, and address.
   - If you are an existing user, you need to log in using your username and password.

2. Browse Movies:
   - After logging in, you can browse the available movies. This will involve querying the Movie table to fetch the list of movies along with their details such as name, language, type, description, and duration.

3. Select a Movie and Show:
   - Choose a movie you are interested in and select the show you want to attend. This will involve querying the Shows table to find the available showtimes and dates for the selected movie.

4. Choose Seats:
   - Select your desired seats from the available ones. This will involve querying the Seats table to check for available seats for the selected show and movie. 

5. Make a Booking:
   - Once you have selected your seats, you need to create a booking. This will involve inserting a new record into the Booking table with details such as the booking title, type, number of tickets, date, description, and your customer ID.

6. Make Payment:
   - After creating a booking, you need to make a payment. This involves inserting a new record into the Payment table with details such as the payment amount, date, description, and your customer ID.

7. Confirm Booking:
   - After successful payment, confirm your booking. You will receive a confirmation that includes the booking details, payment details, and seat numbers.

