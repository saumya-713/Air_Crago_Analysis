# Air-Crago-Analysis

## Course-end SQL Project 2

### Description
Air Cargo is an aviation company that provides air transportation services for passengers and freight. 
Air Cargo uses its aircraft to provide different services with the help of partnerships or alliances with other airlines. 
The company aims to prepare reports on regular passengers, busiest routes, ticket sales details, and other scenarios to improve the ease of travel and booking for customers.

### Project Objective
As a DBA expert, your focus will be to:

- Identify regular customers to provide special offers.
- Analyze the busiest routes to help determine the number of aircraft needed.
- Prepare an analysis of ticket sales details to enhance customer-centric services.

This will improve the company’s operability and make it a more favorable choice for air travel.

> **Note:**   
> You can download the dataset from [this link](https://github.com/saumya-713/Air_Crago_Analysis/raw/refs/heads/main/air_cargo_datasets.zip).


### Dataset Description
The dataset contains several tables with the following details:

#### 1. **customer**
- `customer_id` – ID of the customer
- `first_name` – First name of the customer
- `last_name` – Last name of the customer
- `date_of_birth` – Date of birth of the customer
- `gender` – Gender of the customer

#### 2. **passengers_on_flights**
- `aircraft_id` – ID of each aircraft in a brand
- `route_id` – Route ID from and to location
- `customer_id` – ID of the customer
- `depart` – Departure place from the airport
- `arrival` – Arrival place at the airport
- `seat_num` – Unique seat number for each passenger
- `class_id` – ID of travel class
- `travel_date` – Travel date of each passenger
- `flight_num` – Specific flight number for each route

#### 3. **ticket_details**
- `p_date` – Ticket purchase date
- `customer_id` – ID of the customer
- `aircraft_id` – ID of each aircraft in a brand
- `class_id` – ID of travel class
- `no_of_tickets` – Number of tickets purchased
- `a_code` – Code of each airport
- `price_per_ticket` – Price of a ticket
- `brand` – Aviation service provider for each aircraft

#### 4. **routes**
- `Route_id` – Route ID from and to location
- `Flight_num` – Specific flight number for each route
- `Origin_airport` – Departure location
- `Destination_airport` – Arrival location
- `Aircraft_id` – ID of each aircraft in a brand
- `Distance_miles` – Distance between departure and arrival location
