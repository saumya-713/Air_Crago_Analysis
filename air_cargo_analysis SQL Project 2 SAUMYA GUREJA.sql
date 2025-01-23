-------------------------------------- AIR CARGO PROJECT SAUMYA GUREJA --------------------------------------

create database air_cargo_project;
use air_cargo_project;
show tables;


-- 1.Create an ER diagram for the given airlines database.
describe customer;
describe passengers_on_flights;
describe route_details;
describe ticket_details;

------------------------------------------------------------------------------------------------------------
-- 2.Write a query to create route_details table using suitable data types for the fields, such as route_id, 
-- flight_num, origin_airport, destination_airport, aircraft_id, and distance_miles. 
-- Implement the check constraint for the flight number and unique constraint for the route_id fields.
-- Also, make sure that the distance miles field is greater than 0.

CREATE TABLE route_details
( 
route_id int unique,
flight_num int check (flight_num<>0), 
origin_airport varchar(50), 
destination_airport varchar(50), 
aircraft_id varchar(20),  
distance_miles int check(distance_miles>0)
 );
 
 DESCRIBE route_details;
 
 ------------------------------------------------------------------------------------------------------------
 -- 3. Write a query to display all the passengers (customers) who have travelled in routes 01 to 25. 
 -- Take data  from the passengers_on_flights table.
 
SELECT route_id, c.*  FROM customer c LEFT JOIN passengers_on_flights pf ON 
c.customer_id=pf.customer_id WHERE route_id BETWEEN 01 AND 25 ORDER BY route_id ASC;

-------------------------------------------------------------------------------------------------------------
-- 4. Write a query to identify the number of passengers and total revenue in business class from 
-- the ticket_details table.

SELECT sum(no_of_tickets) Total_Passengers, sum(no_of_tickets * Price_per_ticket) Revenue 
FROM ticket_details WHERE class_id="Bussiness";

--------------------------------------------------------------------------------------------------------------
-- 5. Write a query to display the full name of the customer by extracting the first name and 
-- last name from the customer table.

SELECT concat(first_name," ",last_name) Full_Name FROM customer;

--------------------------------------------------------------------------------------------------------------
-- 6. Write a query to extract the customers who have registered and booked a ticket. Use data from the 
-- customer and ticket_details tables.

SELECT DISTINCT c.* FROM customer c Right Join ticket_details td ON c.customer_id=td.customer_id 
ORDER BY customer_id asc; 

--------------------------------------------------------------------------------------------------------------
-- 7. Write a query to identify the customer’s first name and last name based on their customer ID and 
-- brand (Emirates) from the ticket_details table.

SELECT DISTINCT c.customer_id, c.first_name, c.last_name FROM ticket_details td LEFT JOIN customer c 
ON td.customer_id=c.customer_id 
WHERE brand="Emirates" ORDER BY customer_id asc;

select * from ticket_details;

--------------------------------------------------------------------------------------------------------------
-- 8. Write a query to identify the customers who have travelled by Economy Plus class using Group By and 
-- Having clause on the passengers_on_flights table.

SELECT class_id, count(*) EcoPlus_Passengers FROM passengers_on_flights 
GROUP BY class_id HAVING class_id="Economy Plus";

--------------------------------------------------------------------------------------------------------------
-- 9. Write a query to identify whether the revenue has crossed 10000 using the IF clause on the 
-- ticket_details table.

SELECT sum(Price_per_ticket * no_of_tickets) Revenue, 
IF(sum(no_of_tickets*Price_per_ticket)>10000, "Target Achieved","Target Not Achieved") Status 
FROM ticket_details;

--------------------------------------------------------------------------------------------------------------
-- 10. Write a query to create and grant access to a new user to perform operations on a database.

CREATE USER "data_analyst"@"localhost" IDENTIFIED BY "data_analyst";

SELECT user, host FROM mysql.user WHERE user="data_analyst";

select * from mysql.user;

GRANT select, insert ON air_cargo_project.* TO "data_analyst"@"localhost";

SELECT * FROM mysql.db WHERE user="data_analyst" and Db="air_cargo_project";

SHOW GRANTS FOR "data_analyst"@"localhost";

-------------------------------------------------------------------------------------------------------------
-- 11. Write a query to find the maximum ticket price for each class using window functions on 
-- the ticket_details table.

SELECT DISTINCT class_id, MAX(Price_per_ticket) OVER (PARTITION BY class_id ORDER BY class_id asc) Max_Ticket_Price
FROM ticket_details;

--------------------------------------------------------------------------------------------------------------
-- 12. Write a query to extract the passengers whose route ID is 4 by improving the speed and performance 
-- of the passengers_on_flights table.

ALTER TABLE passengers_on_flights
ADD PRIMARY KEY (route_id, customer_id);

SHOW INDEX FROM passengers_on_flights WHERE Key_name = 'PRIMARY';

--------------------------------------------------------------------------------------------------------------
-- 13. For the route ID 4, write a query to view the execution plan of the passengers_on_flights table

SELECT customer_id
FROM passengers_on_flights
WHERE route_id = 4;

describe passengers_on_flights;

EXPLAIN SELECT customer_id
FROM passengers_on_flights
WHERE route_id = 4;

--------------------------------------------------------------------------------------------------------------
-- 14. Write a query to calculate the total price of all tickets booked by a customer across different 
-- aircraft IDs using rollup function.

SELECT td.customer_id, 
COALESCE(td.aircraft_id, 'Total Spent by this customer') AS Aircraft, 
SUM(td.no_of_tickets * td.Price_per_ticket) AS Total_Ticket_Price 
FROM ticket_details td GROUP BY td.customer_id, td.aircraft_id WITH ROLLUP;

--------------------------------------------------------------------------------------------------------------
-- 15. Write a query to create a view with only business class customers along with the brand of airlines.

CREATE VIEW business_class_customers AS
SELECT t.customer_id, c.first_name,c.last_name,t.brand 
FROM ticket_details t,
customer c  
WHERE t.customer_id = c.customer_id AND t.class_id = 'Bussiness';

SELECT * FROM business_class_customers;

--------------------------------------------------------------------------------------------------------------
-- 16. Write a query to create a stored procedure to get the details of all passengers flying between 
-- a range of routes defined in run time. Also, return an error message if the table doesn't exist.

DELIMITER $$
CREATE PROCEDURE passengers_between_route_range(IN start_route_id INT, IN end_route_id INT)
BEGIN
    IF NOT EXISTS (SELECT * FROM information_schema.tables 
                   WHERE table_name = 'passengers_on_flights' AND table_schema = DATABASE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Table passengers_on_flights does not exist.';
    ELSE
        SELECT pf.customer_id, c.first_name, c.last_name, pf.route_id, pf.depart, pf.arrival
        FROM passengers_on_flights pf
        JOIN customer c ON pf.customer_id = c.customer_id
        WHERE pf.route_id BETWEEN start_route_id AND end_route_id;
    END IF;
END$$
DELIMITER ;

CALL passengers_between_route_range(1,10);

-------------------------------------------------------------------------------------------------------------
-- 17. Write a query to create a stored procedure that extracts all the details from the routes
--  table where the travelled distance is more than 2000 miles.

DELIMITER //

CREATE PROCEDURE long_distance_route()
BEGIN
    IF NOT EXISTS (SELECT * FROM information_schema.tables 
                   WHERE table_name = 'routes' 
                   AND table_schema = DATABASE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Table routes does not exist.';
    ELSE
        SELECT * FROM routes
        WHERE distance_miles > 2000;
    END IF;
END //

CALL long_distance_route();

--------------------------------------------------------------------------------------------------------------
-- 18. Write a query to create a stored procedure that groups the distance 
-- travelled by each flight into three categories. The categories are, short distance travel (SDT) 
-- for >=0 AND <= 2000 miles, intermediate distance travel (IDT) for >2000 AND <=6500,
--  and long-distance travel (LDT) for >6500.

DELIMITER //

CREATE PROCEDURE flight_distance_category()
BEGIN
    IF NOT EXISTS (SELECT * FROM information_schema.tables 
                   WHERE table_name = 'routes' 
                   AND table_schema = DATABASE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Table routes does not exist.';
    ELSE
        SELECT 
            flight_num,
            CASE 
                WHEN distance_miles >= 0 AND distance_miles <= 2000 THEN 'Short Distance Travel'
                WHEN distance_miles > 2000 AND distance_miles <= 6500 THEN 'Intermediate Distance Travel'
                WHEN distance_miles > 6500 THEN 'Long Distance Travel'
            END AS distance_category,
            distance_miles
        FROM routes;
    END IF;
END //

DELIMITER ;

CALL flight_distance_category();

--------------------------------------------------------------------------------------------------------------
-- 19. Write a query to extract ticket purchase date, customer ID, class ID and specify if the 
-- complimentary services are provided for the specific class using a stored function in stored procedure 
-- on the ticket_details table.

DELIMITER //
CREATE FUNCTION complimentary_services(class_id VARCHAR(50))
RETURNS VARCHAR(3)
DETERMINISTIC
BEGIN
    DECLARE service VARCHAR(3);
    IF class_id IN ('Business', 'Economy Plus') THEN
        SET service = 'Yes';
    ELSE
        SET service = 'No';
    END IF;
    RETURN service;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ticket_details_with_services()
BEGIN
    IF NOT EXISTS (SELECT * FROM information_schema.tables 
                   WHERE table_name = 'ticket_details' 
                   AND table_schema = DATABASE()) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Table ticket_details does not exist.';
    ELSE
        SELECT 
            p_date AS ticket_purchase_date,
            customer_id,
            class_id,
            complimentary_services(class_id)
        FROM ticket_details;
    END IF;
END //
DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------
-- 20. Write a query to extract the first record of the customer whose last name ends with Scott using a 
-- cursor from the customer table.

DELIMITER //
CREATE PROCEDURE last_name_scott()
BEGIN
    DECLARE cust_id INT;
    DECLARE fst_name VARCHAR(128);
    DECLARE lst_name VARCHAR(128);
    DECLARE done INT DEFAULT 0;

    DECLARE find_scott CURSOR FOR
      SELECT customer_id, first_name, last_name
      FROM customer
      WHERE last_name LIKE '%Scott'; 

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN find_scott;

read_loop: LOOP
        FETCH find_scott INTO cust_id, fst_name, lst_name;
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;
        SELECT cust_id AS CustomerID,
               fst_name AS FirstName,
               lst_name AS LastName;
    END LOOP;
    CLOSE find_scott;
END //
DELIMITER ;



